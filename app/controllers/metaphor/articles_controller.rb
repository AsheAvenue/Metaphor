require "open-uri"

module Metaphor
  class ArticlesController < MetaphorController
    
    layout 'metaphor/metaphor'
    
    before_filter :require_login, :except => :vote
    skip_authorize_resource :only => :vote
    
    def index
      if Rails.env.production? && Settings.admin.redirect_admin_to_separate_admin_app && request.subdomains.first != Settings.admin.subdomain
        redirect_to Settings.admin.admin_url
      else
        @articles = Article.recently_created.limit(100)
        @templates = Template.all
      end
    end
    
    def search 
      search_term = params[:search_term]
      
      if search_term.empty?
        all_articles = Article.where(true).recently_created.limit(100)
      else
        all_articles = Article.text_search(params[:search_term]).limit(100)
      end
      
      @articles = []
      all_articles.each do |article|
        puts article.title
        @articles << article.current
      end
    end
    
    def show
      redirect_to edit_article_path(params[:id])
    end
  
    def edit
      @articles = Article.recently_updated.limit(10)
      @article = Article.includes(:categories).find(params[:id])
      
      # get the indexes
      @last_published_revision_index = nil;
      @next_published_revision_index = nil;
      @article.versions.each do |version|
        @last_published_revision_index = version.index if version.id == @article.last_published_revision_id
        @next_published_revision_index = version.index if version.id == @article.next_published_revision_id
      end
      
      #set up the templates
      @templates = Template.all
      
      @templates = []
      t = Template.all
      
      # Loop through and
      t.each do |template|
        if @article.template.starts_with?('simple') && template.name.starts_with?('Simple')
          @templates << template
        elsif !@article.template.starts_with?('simple') && !template.name.starts_with?('Simple')
          @templates << template
        end
      end
      
    end
    
    def revision
      @articles = Article.recently_updated.limit(10)
      @original_article = Article.includes(:categories).find(params[:id])
      
      # get the indexes
      @last_published_revision_index = nil;
      @next_published_revision_index = nil;
      @original_article.versions.each do |v|
        @last_published_revision_index = v.index if v.id == @original_article.last_published_revision_id
        @next_published_revision_index = v.index if v.id == @original_article.next_published_revision_id
      end
      
      #get the reverted version
      @version_id = params[:version_id].to_i
      version = @original_article.versions.find(@version_id)
      @article = @original_article.version_at(version.created_at)
      @article.last_published_revision_id = @original_article.last_published_revision_id
      @article.next_published_revision_id = @original_article.next_published_revision_id
      @article.publish_next_revision_at = @original_article.publish_next_revision_at
      
      #set up the templates
      @templates = Template.all
      
      #use the standard edit view
      render :edit
    end

    def publish
      article = Article.find(params[:id])
      if validate_before_publish(article)
        version_id = params[:version_id].to_i
        article.last_published_revision_id = version_id
        article.next_published_revision_id = nil 
        article.publish_next_revision_at = nil 
        article.save!
        
        update_article_cache(article)
        
        render :text => "success"
      else
        render :text => "contents"
      end
    end

    def unpublish
      article = Article.find(params[:id])
      article.last_published_revision_id = nil
      article.next_published_revision_id = nil 
      article.publish_next_revision_at = nil 
      article.save!
      
      update_article_cache(article)
      
      render :nothing => true
    end

    def schedule
      article = Article.find(params[:id])
      if validate_before_publish(article)
        version_id = params[:version_id].to_i
        article.next_published_revision_id = version_id 
        article.publish_next_revision_at = DateTime.parse("#{params[:date]} #{params[:time]}") 
        article.save!
        
        update_article_cache(article)
        
        render :text => "success"
      else
        render :text => "contents"
      end
    end

    def unschedule
      article = Article.find(params[:id])
      article.next_published_revision_id = nil 
      article.publish_next_revision_at = nil
      article.save!
      
      update_article_cache(article)
      
      render :nothing => true
    end

    def new
      @articles = Article.where(true).recently_created.limit(10)
      @article = Article.new
      @templates = []
      t = Template.all
      
      # Loop through and remove the simple items, since they should only be available when creating new articles in the mobile cms
      t.each do |template|
        if !template.name.starts_with?('Simple')
          @templates << template
        end
      end
      
    end
  
    def create
      @article = Article.create(params[:article])
      begin
        if @article.save!
          update_article_cache(@article)
          redirect_to edit_article_path(@article.id)
        else
          raise "Error saving article"
        end
      rescue
        flash[:alert] = "Please enter a title, ensure your slug is unique, and select a template"
        @articles = Article.where(true).recently_created.limit(10)
        @templates = Template.all
        render :new
      end
    end
  
    def update
      article = Article.find(params[:id])
      
      # Go down the path of saving if we don't have a version id, 
      # or skip saving and go directly to the content editor if we
      # do have a version id
      if params[:version]
        redirect_to article_editor_version_path(params[:id], params[:version])
      else
        # Update the article
        # Open the url that's been returned by Filepicker.
        # Then remove the default image from params so it doesn't get updated 
        # via update_attributes, which will cause a validation error
        if params[:article][:default_image_selected] == "true" && params[:article][:default_image] != '/default_images/original/missing.png'
          url = params[:article][:default_image]
          original_filename = params[:article][:default_image_original_filename]
          article.default_image = open(url)
          article.default_image.instance_write(:file_name, original_filename)
        
          # create the first image item if autoimage is enabled
          if Settings.articles.autoimage.enabled
            # get the template and see if it has an image component in it. 
            t = Template.find_by_slug(article.template)
            position = t.get_first_component_position('image')

            # if it does
            if position != nil
              # if there arent' any images, create a new Image object
              if article.images.length == 0
                i = Image.new
                i.image = open(url)
                i.image.instance_write(:file_name, original_filename)
                i.name = article.title
                i.slug = "#{article.slug}-image"
                i.save!
      
                # add the image object as a widget to the entity contents in the position saved above
                widget = EntityContent.new
                widget.entity = article
                widget.content = i
                widget.position = position
                widget.save! 
              end          
            end
          end
        end
        params[:article].delete :default_image
      
        # Proceed to update the object accordingly
        article.update_attributes(params[:article])
      
        # update the cache
        update_article_cache(article)
      
        # now redirect accordingly
        if(params["edit-content"] == "true")
          redirect_to article_editor_path(params[:id])
        else
          redirect_to edit_article_path(params[:id])
        end
      end
    end
  
    def checkslug
      article = Article.find_by_slug(params[:slug])
      if article
        render :text => 'TRUE'
      else
        render :text => 'FALSE'
      end
    end
    
    def taglist
      render json: Article.tag_counts_on(:tags)
                   .where("name ilike ?","%#{params[:term]}%")
                   .order("name ilike '%#{params[:term]}%' DESC, LENGTH(name) ASC, name ASC")
                   .map(&:to_s)
                   .map(&:downcase)
    end
    
    def related_entity_list
      entity = params[:related_entity]
      render json: entity
                   .constantize
                   .select("name as value, id as id")
                   .where("name ilike ?","%#{params[:term]}%")
                   .order("name ilike '%#{params[:term]}%' DESC, LENGTH(name) ASC, name ASC")
    end
    
    def vote
      entity_type = params[:entity_type]
      entity_id = params[:entity_id]
      if entity_type == "article"
        a = Article.find(entity_id)
        a.upvotes = a.upvotes + 1
        if a.save
          render :text => a.upvotes
        else
          render :text => "Failure"
        end
      end
    end
      
    private
    
    def validate_before_publish(article)
      # get the template
      template_slugs = []
      template = Template.find_by_slug(article.template)
      template.components.each do |component|
        slug = component.slug
        if !['meta', 'body'].include? slug
          template_slugs << slug
        end
      end
      
      # get the entity contents
      entity_contents = article.entity_contents
      entity_contents.each do |entity_content|
        slug = entity_content.content_type.downcase
        if template_slugs.include? slug
          template_slugs.delete slug
        end
      end
      
      # return false if they don't match
      return template_slugs.length == 0
    end
    
    def update_article_cache(article)
      Rails.cache.delete("article_#{article.slug}")
    end
    
  end
end
