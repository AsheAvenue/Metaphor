module Metaphor
  class PickerController < MetaphorController

    skip_load_and_authorize_resource #don't let cancan try and instantiate a non-existent "Picker" resource
  
    layout 'metaphor/picker'

    def article
      @articles = Article.recently_created.limit(10)
    end
    
    def searchArticle
      @results = Article.text_search(params[:search_term]).order('articles.created_at desc').limit(10)
    end

    def event
      @events = Event.recently_created.limit(10)
    end
    
    def searchEvent
      @results = Event.text_search(params[:search_term]).order('events.created_at desc').limit(10)
    end

    def gallery
      @galleries = Gallery.order('galleries.created_at desc').limit(10)
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
      @videos = Video.order('videos.created_at desc').limit(10)
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

    def vimeo
      @vimeos = Vimeo.order('vimeos.created_at desc').limit(10)
      @vimeo = Vimeo.new
    end

    def addVimeo
      @v = Vimeo.new
      @v.name = params[:vimeo_name]
      @v.slug = params[:vimeo_slug]
      @v.code = params[:vimeo_code]
      @v.save!
    end
    
    def searchVimeo
      @results = Vimeo.text_search(params[:search_term]).order('vimeos.created_at desc').limit(10)
    end

    def image
      @images = Image.order('images.created_at desc').limit(10)
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
      @sounds = Sound.limit(10).all
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