class Admin::PickerController < Admin::AdminController
  skip_load_and_authorize_resource #don't let cancan try and instantiate a non-existent "Picker" resource
  
  layout 'admin_popup'

  def article
    @articles = Article.where(true).newest
  end

  def component
    @components = Component.all
  end

  def video
    @videos = Video.all
  end

  def addVideo
    @v = Video.new
    @v.name = params[:video_name]
    @v.slug = params[:video_slug]
    @v.code = params[:video_code]
    @v.save!
  end

  def image
    @images = Image.all
    @image = Image.new
  end

  def addImage
    @i = Image.new
    @i.name = params[:image_name]
    @i.slug = params[:image_slug]
    @i.caption = params[:image_caption]
    @i.credit = params[:image_credit]
    @i.image_url = params[:image_url]
    @i.save!
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
  
  def gallery
    @galleries = Gallery.all
    @gallery = Gallery.new
  end

  def addGallery
    @g = Gallery.new
    @g.name = params[:gallery_name]
    @g.slug = params[:gallery_slug]
    @g.save!
  end
  
end
