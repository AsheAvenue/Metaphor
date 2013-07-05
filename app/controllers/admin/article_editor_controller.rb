class Admin::ArticleEditorController < Admin::AdminController
  skip_load_and_authorize_resource #don't let cancan try and instantiate a non-existent "ArticleEditor" resource
  
  layout 'article_editor'

  def index
    # Get the article
    @article = Article.find(params[:id])
    
    # Get the template if it's been defined,
    # otherwise redirect
    if @article.template
      @template = Template.find_by_slug(@article.template)
    end
  end
  
end
