require_dependency "metaphor/application_controller"

require "open-uri"

module Metaphor
  class ArticlesController < ApplicationController
    
    layout 'metaphor/metaphor'
    
    def index
      @articles = Article.where(true).newest
    end
    
    def show
      redirect_to edit_article_path(params[:id])
    end
  
    def edit
      @articles = Article.where(true).newest
      @article = Article.includes(:categories, :series).find(params[:id])
      
      #set up the templates
      @templates = Template.all
    end
    
    def revision
      @articles = Article.where(true).newest
      @original_article = Article.includes(:categories, :series).find(params[:id])
      
      #get the reverted version
      @version_index = params[:version_index].to_i
      @original_article.versions.each do |version|
        if version.index == @version_index
          @article = @original_article.version_at(version.created_at)
          @article.last_published_revision_index = @original_article.last_published_revision_index
          @article.next_published_revision_index = @original_article.next_published_revision_index
          @article.publish_next_revision_at = @original_article.publish_next_revision_at
          break
        end
      end
      
      #set up the templates
      @templates = Template.all
      
      #use the standard edit view
      render :edit
    end

    def publish
      article = Article.find(params[:id])
      version_index = params[:version_index].to_i
      article.last_published_revision_index = version_index
      article.next_published_revision_index = nil 
      article.publish_next_revision_at = nil 
      article.save!
      render :nothing => true
    end

    def unpublish
      article = Article.find(params[:id])
      article.last_published_revision_index = nil
      article.next_published_revision_index = nil 
      article.publish_next_revision_at = nil 
      article.save!
      render :nothing => true
    end

    def schedule
      article = Article.find(params[:id])
      version_index = params[:version_index].to_i
      article.next_published_revision_index = version_index 
      article.publish_next_revision_at = DateTime.parse("#{params[:date]} #{params[:time]}") 
      article.save!
      render :nothing => true
    end

    def unschedule
      article = Article.find(params[:id])
      article.next_published_revision_index = nil 
      article.publish_next_revision_at = nil
      article.save!
      render :nothing => true
    end

    def new
      @articles = Article.where(true).newest
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
      if  params[:article][:default_image_selected] == "true" && params[:article][:default_image] != '/default_images/original/missing.png'
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
    end
    
    def related_entity_list
      entity = params[:related_entity]
      render json: entity
                   .constantize
                   .select(:name)
                   .where("name ilike ?","%#{params[:term]}%")
                   .order("name ilike '%#{params[:term]}%' DESC, LENGTH(name) ASC, name ASC").map{|e| e.name}
    end
  
    def preview
      
    end
    
  end
end
