module Metaphor
  class ArticleEditorController < ApplicationController

    skip_load_and_authorize_resource #don't let cancan try and instantiate a non-existent "ArticleEditor" resource
  
    layout 'metaphor/article_editor'

    def index
      # Get the article
      @article = Article.find(params[:id])
      session[:article_id] = @article.id
    
      # Get the template if it's been defined
      if @article.template != ""
        @template = Template.find_by_slug(@article.template)
      else 
        redirect_to article_path(@article)
      end
    
      #get the widgets
      @widgets = Hash.new
      content_widgets = @article.content_widgets.order('position ASC')
      content_widgets.each do |w|
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
      c = ContentWidget.find_by_entity_id_and_entity_type_and_content_type_and_position(@article.id, 'Article', 'Video', @position)
      if c
        c.content = @video
      else
        c = ContentWidget.new
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
      c = ContentWidget.find_by_entity_id_and_entity_type_and_content_type_and_position(@article.id, 'Article', 'Image', @position)
      if c
        c.content = @image
      else
        c = ContentWidget.new
        c.entity = @article
        c.content = @image
        c.position = @position
      end
    
      #save the content widget and continue to the js.erb portion
      c.save!
    
    end
  
    def select_gallery
      # get the data
      @article = Article.find(params[:article_id])
      @gallery = Gallery.find(params[:gallery_id])
      @position = params[:position]
    
      # get the content widget if it already exists in that place and 
      # update it... or create a new one
      c = ContentWidget.find_by_entity_id_and_entity_type_and_content_type_and_position(@article.id, 'Article', 'Gallery', @position)
      if c
        c.content = @gallery
      else
        c = ContentWidget.new
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
      c = ContentWidget.find_by_entity_id_and_entity_type_and_content_type_and_position(@article.id, 'Article', 'Sound', @position)
      if c
        c.content = @sound
      else
        c = ContentWidget.new
        c.entity = @article
        c.content = @sound
        c.position = @position
      end
    
      #save the content widget and continue to the js.erb portion
      c.save!
    
    end
  
    def update_body
      @article = Article.find(params[:article_id])
      body = params[:body]
      @article.body = body
      @article.save!
      render :nothing => true
    end  
  
  end

end