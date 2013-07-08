class Admin::GalleryEditorController < Admin::AdminController
  skip_load_and_authorize_resource #don't let cancan try and instantiate a non-existent "ArticleEditor" resource
  
  layout 'gallery_editor'

  def index
    # Get the gallery
    @gallery = Gallery.find(params[:id])
    
    #get the widgets
    @widgets = @gallery.content_widgets.order('position ASC')
    
    #get the article we were just editing
    @article = Article.find(session[:article_id])
  end
  
  def add_image
    @i = Image.new
    @i.name = params[:image_name]
    @i.slug = params[:image_slug]
    @i.caption = params[:image_caption]
    @i.credit = params[:image_credit]
    @i.image_url = params[:image_url]
    @i.save!
  end
  
  def select_image
    # get the data
    @gallery = Gallery.find(params[:gallery_id])
    @image = Image.find(params[:image_id])
    @position = params[:position]
    
    # get the content widget if it already exists in that place and 
    # update it... or create a new one
    c = ContentWidget.new
    c.entity = @gallery
    c.content = @image
    c.position = @position
    
    #save the content widget and continue to the js.erb portion
    c.save!
    
  end
  
end
