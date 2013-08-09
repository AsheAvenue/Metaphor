require "open-uri"

module Metaphor
  class ArticlesController < ApplicationController
    
    layout 'metaphor/metaphor'
    
    def index
      @articles = get_current_articles
      @templates = Template.all
    end
    
    def show
      redirect_to edit_article_path(params[:id])
    end
  
    def edit
      @articles = get_current_articles
      @article = Article.includes(:categories, :series).find(params[:id])
      
      # get the indexes
      @last_published_revision_index = nil;
      @next_published_revision_index = nil;
      @article.versions.each do |version|
        @last_published_revision_index = version.index if version.id == @article.last_published_revision_id
        @next_published_revision_index = version.index if version.id == @article.next_published_revision_id
      end
      
      #set up the templates
      @templates = Template.all
    end
    
    def revision
      @articles = get_current_articles
      @original_article = Article.includes(:categories, :series).find(params[:id])
      
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
      version_id = params[:version_id].to_i
      article.last_published_revision_id = version_id
      article.next_published_revision_id = nil 
      article.publish_next_revision_at = nil 
      article.save!
      render :nothing => true
    end

    def unpublish
      article = Article.find(params[:id])
      article.last_published_revision_id = nil
      article.next_published_revision_id = nil 
      article.publish_next_revision_at = nil 
      article.save!
      render :nothing => true
    end

    def schedule
      article = Article.find(params[:id])
      version_id = params[:version_id].to_i
      article.next_published_revision_id = version_id 
      article.publish_next_revision_at = DateTime.parse("#{params[:date]} #{params[:time]}") 
      article.save!
      render :nothing => true
    end

    def unschedule
      article = Article.find(params[:id])
      article.next_published_revision_id = nil 
      article.publish_next_revision_at = nil
      article.save!
      render :nothing => true
    end

    def new
      @articles = Article.where(true).recently_created
      @article = Article.new
    
      #set up the templates
      @templates = Template.all
    end
  
    def create
      article = Article.create(params[:article])
      article.save!
      redirect_to edit_article_path(article.id)
    end
  
    def update
      article = Article.find(params[:id])
    
      # Open the url that's been returned by Filepicker.
      # Then remove the default image from params so it doesn't get updated 
      # via update_attributes, which will cause a validation error
      if params[:article][:default_image_selected] == "true" && params[:article][:default_image] != '/default_images/original/missing.png'
        url = params[:article][:default_image]
        original_filename = params[:article][:default_image_original_filename]
        article.default_image = open(url)
        article.default_image.instance_write(:file_name, original_filename)
      end
      params[:article].delete :default_image
    
      # Proceed to update the object accordingly
      article.update_attributes(params[:article])
      
      if(params["edit-content"] == "true")
        redirect_to article_editor_path(params[:id])
      else
        redirect_to edit_article_path(params[:id])
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
      
    private
    
    def get_current_articles
      all_articles = Article.where(true).recently_updated
      articles = []
      all_articles.each do |article|
        articles << article.current
      end
      articles
    end
    
  end
end
