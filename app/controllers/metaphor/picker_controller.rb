module Metaphor
  class PickerController < ApplicationController

    skip_load_and_authorize_resource #don't let cancan try and instantiate a non-existent "Picker" resource
  
    layout 'metaphor/picker'

    def article
      @articles = Article.where(true).recently_updated
    end
    
    def searchArticle
      @results = Article.text_search(params[:search_term]).order('articles.updated_at desc').limit(10)
    end

    def event
      @events = Event.where(true).recently_updated
    end
    
    def searchEvent
      @results = Event.text_search(params[:search_term]).order('events.updated_at desc').limit(10)
    end

    def gallery
      puts "HERE!!!!!"
      @galleries = Gallery.where(true).order('galleries.updated_at desc')
      @gallery = Gallery.new
    end

    def addGallery
      @g = Gallery.new
      @g.name = params[:gallery_name]
      @g.slug = params[:gallery_slug]
      @g.save!
    end
    
    def searchGallery
      @results = Gallery.text_search(params[:search_term]).order('galleries.created_at desc').limit(10)
    end
    
    def component
      @components = Component.all
    end

    def video
      @videos = Video.where(true).order('videos.updated_at desc')
      @video = Video.new
    end

    def addVideo
      @v = Video.new
      @v.name = params[:video_name]
      @v.slug = params[:video_slug]
      @v.code = params[:video_code]
      @v.save!
    end
    
    def searchVideo
      @results = Video.text_search(params[:search_term]).order('videos.created_at desc').limit(10)
    end

    def image
      @images = Image.where(true).order('images.updated_at desc')
      @image = Image.new
    end

    def addImage
      @i = Image.new
      @i.name = params[:image_name]
      @i.slug = params[:image_slug]
      @i.caption = params[:image_caption]
      @i.credit = params[:image_credit]
    
      # Open the url that's been returned by Filepicker.
      # Then remove the default image from params so it doesn't get updated 
      # via update_attributes, which will cause a validation error
      if params[:image_url] != '/default_images/original/missing.png'
        url = params[:image_url]
        original_filename = params[:image_original_filename]
        @i.image = open(url)
        @i.image.instance_write(:file_name, original_filename)
      end
    
      # now save
      @i.save!
    end
    
    def searchImage
      @results = Image.text_search(params[:search_term]).order('images.created_at desc').limit(10)
    end
  
    def sound
      @sounds = Sound.all
    end

    def addSound
      @s = Sound.new
      @s.name = params[:sound_name]
      @s.slug = params[:sound_slug]
      @s.code = params[:sound_code]
      @s.save!
    end
    
    def searchSound
      @results = Sound.text_search(params[:search_term]).order('sounds.created_at desc').limit(10)
    end
  
  end

end