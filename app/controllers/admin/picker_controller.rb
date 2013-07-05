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
  
end
