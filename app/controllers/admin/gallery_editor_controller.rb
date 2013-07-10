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
  
  def sort
    params[:image].each_with_index do |id, index|
      ContentWidget.update_all({position: index+1}, {id: id})
    end 
    render nothing: true
  end
  
  def add_image
    @i = Image.new
    @i.image_url = params[:image_url]
    @i.save!
    
    @i.slug = "gallery-#{params[:gallery_id]}-image-#{@i.id}"
    @i.save!
  end
  
  def remove_image
    w = ContentWidget.find(params[:id])
    w.destroy
  end
  
  def save_image
    w = ContentWidget.find(params[:content_widget_id])
    i = w.content
    i.caption = params[:image_caption]
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
    @widget = ContentWidget.new
    @widget.entity = @gallery
    @widget.content = @image
    @widget.position = @position
    
    #save the content widget and continue to the js.erb portion
    @widget.save! 
  end
  
  def image_info
    widget = ContentWidget.find(params[:id])
    puts widget
    @image = widget.content
  end
  
end
