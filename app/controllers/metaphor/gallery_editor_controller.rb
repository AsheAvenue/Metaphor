module Metaphor
  class GalleryEditorController < ApplicationController
    skip_load_and_authorize_resource #don't let cancan try and instantiate a non-existent "ArticleEditor" resource
  
    layout 'metaphor/gallery_editor'

    def index
      # Get the gallery
      @gallery = Gallery.find(params[:id])
    
      #get the widgets
      @widgets = @gallery.entity_contents.order('position ASC')
    
      #get the article we were just editing
      @article = Article.find(session[:article_id])
    end
  
    def sort
      params[:image].each_with_index do |id, index|
        EntityContent.update_all({position: index+1}, {id: id})
      end 
      render nothing: true
    end
  
    def add_image
      @i = Image.new
    
      # Open the url that's been returned by Filepicker.
      # Then remove the default image from params so it doesn't get updated 
      # via update_attributes, which will cause a validation error
      if params[:image_url] != '/default_images/original/missing.png'
        url = params[:image_url]
        original_filename = params[:image_original_filename]
        @i.image = open(url)
        @i.image.instance_write(:file_name, original_filename)
      end
      @i.save!
    
      @i.slug = "gallery-#{params[:gallery_id]}-image-#{@i.id}"
      @i.save!
    end
  
    def remove_image
      w = EntityContent.find(params[:id])
      w.destroy
    end
  
    def save_image
      w = EntityContent.find(params[:entity_content_id])
      i = w.content
      i.caption = params[:image_caption]
      i.name = i.caption if !i.name
      i.credit = params[:image_credit]
      i.save!
      render nothing: true
    end
  
    def select_image
      # get the data
      @gallery = Gallery.find(params[:gallery_id])
      @image = Image.find(params[:image_id])
      @position = params[:position]
    
      # get the content widget if it already exists in that place and 
      # update it... or create a new one
      @widget = EntityContent.new
      @widget.entity = @gallery
      @widget.content = @image
      @widget.position = @position
    
      #save the content widget and continue to the js.erb portion
      @widget.save! 
    end
  
    def image_info
      widget = EntityContent.find(params[:id])
      @image = widget.content
    end
  
  end

end