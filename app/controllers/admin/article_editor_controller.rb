class Admin::ArticleEditorController < Admin::AdminController
  skip_load_and_authorize_resource #don't let cancan try and instantiate a non-existent "ArticleEditor" resource
  
  layout 'article_editor'

  def index
    # Get the article
    @article = Article.find(params[:id])
    
    # Get the template if it's been defined
    if @article.template
      @template = Template.find_by_slug(@article.template)
    end
    
    #get the widgets
    @widgets = Hash.new
    content_widgets = @article.content_widgets.order('position ASC')
    content_widgets.each do |w|
      @widgets["#{w.position}"] = w
    end
  end
  
  def select_top_video
    # get the data
    @article = Article.find(params[:article_id])
    @video = Video.find(params[:video_id])
    position = params[:position]
    
    # get the content widget if it already exists in that place and 
    # update it... or create a new one
    c = ContentWidget.find_by_entity_id_and_entity_type_and_content_type_and_position(@article.id, 'Article', 'Video', position)
    if c
      c.content = @video
    else
      c = ContentWidget.new
      c.entity = @article
      c.content = @video
      c.position = position
    end
    
    #save the content widget and continue to the js.erb portion
    c.save!
    
  end
  
end
