require "open-uri"

module Metaphor
  class ArticleEditorController < MetaphorController

    skip_load_and_authorize_resource #don't let cancan try and instantiate a non-existent "ArticleEditor" resource
  
    layout 'metaphor/article_editor'

    def index
      # Get the article
      @article = Article.find(params[:id])
      session[:article_id] = @article.id
      @version_id = params[:version_id] 
    
      # get a specific version of the article if a version id is being passed in.
      if @version_id && @version_id != ""
        version = @article.versions.find(@version_id)
        if version
          @article = @article.version_at(version.created_at)
        end
      end
      
      # Get the template if it's been defined
      if @article.template != ""
        @template = Template.find_by_slug(@article.template)
      else 
        redirect_to article_path(@article)
      end
    
      #get the widgets
      @widgets = Hash.new
      entity_contents = @article.entity_contents.order('position ASC')
      entity_contents.each do |w|
        @widgets["#{w.position}"] = w
      end
 
    end
  
    def select_video
      # get the data
      @article = Article.find(params[:article_id])
      @video = Video.find(params[:video_id])
      @position = params[:position]
    
      # get the content widget if it already exists in that place and 
      # update it... or create a new one
      c = EntityContent.find_by_entity_id_and_entity_type_and_content_type_and_position(@article.id, 'Article', 'Video', @position)
      if c
        c.content = @video
      else
        c = EntityContent.new
        c.entity = @article
        c.content = @video
        c.position = @position
      end
    
      #save the content widget and continue to the js.erb portion
      c.save!
    
    end  
  
    def select_image
      # get the data
      @article = Article.find(params[:article_id])
      @image = Image.find(params[:image_id])
      @position = params[:position]
    
      # get the content widget if it already exists in that place and 
      # update it... or create a new one
      c = EntityContent.find_by_entity_id_and_entity_type_and_content_type_and_position(@article.id, 'Article', 'Image', @position)
      if c
        c.content = @image
      else
        c = EntityContent.new
        c.entity = @article
        c.content = @image
        c.position = @position
      end
    
      #save the content widget and continue to the js.erb portion
      c.save!
    
      #now create the article default image if it doesn't exist yet
      if Settings.articles.autoimage.enabled
        if @article.default_image.url == '/default_images/original/missing.png' || @article.default_image == nil
          @article.default_image = open(@image.image.url)
          @article.default_image.instance_write(:file_name, @image.image.original_filename)
          @article.save!
        end
      end
    end
  
    def select_gallery
      # get the data
      @article = Article.find(params[:article_id])
      @gallery = Gallery.find(params[:gallery_id])
      @position = params[:position]
    
      # get the content widget if it already exists in that place and 
      # update it... or create a new one
      c = EntityContent.find_by_entity_id_and_entity_type_and_content_type_and_position(@article.id, 'Article', 'Gallery', @position)
      if c
        c.content = @gallery
      else
        c = EntityContent.new
        c.entity = @article
        c.content = @gallery
        c.position = @position
      end
    
      #save the content widget and continue to the js.erb portion
      c.save!
    
    end
  
    def select_sound
      # get the data
      @article = Article.find(params[:article_id])
      @sound = Sound.find(params[:sound_id])
      @position = params[:position]
    
      # get the content widget if it already exists in that place and 
      # update it... or create a new one
      c = EntityContent.find_by_entity_id_and_entity_type_and_content_type_and_position(@article.id, 'Article', 'Sound', @position)
      if c
        c.content = @sound
      else
        c = EntityContent.new
        c.entity = @article
        c.content = @sound
        c.position = @position
      end
    
      #save the content widget and continue to the js.erb portion
      c.save!
    
    end
  
    def update_body
      @article = Article.find(params[:id])
      body = params[:body]
      
      # remove any superfluous "\n" and "\t" from the body
      body = body.gsub(/\n/, '')
      body = body.gsub(/\t/, '')
      
      @article.body = body
      @article.save!
      
      Rails.cache.delete("article_#{@article.slug}")
      Rails.cache.delete("article_#{@article.slug}_related_articles")
      Rails.cache.delete("article_#{@article.slug}_previous")
      Rails.cache.delete("article_#{@article.slug}_next")
      
      render :nothing => true
    end  

    def get_image_for_body
      @image = Image.find(params[:image_id])
    end  

    def get_video_for_body
      @video = Video.find(params[:video_id])
    end 

    def get_sound_for_body
      @sound = Sound.find(params[:sound_id])
    end  
  
  end

end