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

end
