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
      @article = Article.includes(:categories, :series).find(params[:id])
      
      #get the reverted version
      @version_index = params[:version_index].to_i
      @article.versions.each do |version|
        if version.index == @version_index
          @article = @article.version_at(version.created_at)
          break
        end
      end
      
      #set up the templates
      @templates = Template.all
      
      #use the standard edit view
      render :edit
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
  
    def preview
      @article = Article.find(params[:id])
    end
    
  end
end
