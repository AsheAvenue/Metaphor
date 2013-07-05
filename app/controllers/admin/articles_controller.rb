class Admin::ArticlesController < Admin::AdminController

  layout :resolve_layout

  def index
    @articles = Article.where(true).newest
  end

  def show
    redirect_to edit_admin_article_path(params[:id])
  end
  
  def edit
    @articles = Article.where(true).newest
    @article = Article.includes(:categories, :series).find(params[:id])
    
    #set up the templates
    @templates = Template.all
  end

  def new
    @articles = Article.where(true).newest
    @article = Article.new
    
    #set up the templates
    @templates = Template.all
  end
  
  def create
    article = Article.create(params[:article])
    article.save!
    redirect_to edit_admin_article_path(article.id)
  end
  
  def update
    article = Article.find(params[:id])
    article.update_attributes(params[:article])
    article.save
    
    if(params["edit-content"] == "true")
      redirect_to admin_article_editor_path(params[:id])
    else
      redirect_to edit_admin_article_path(params[:id])
    end
  end
  
  def checkslug
    article = Article.find_by_slug(params[:slug])
    if article
      render :text => 'TRUE'
    else
      render :text => 'FALSE'
    end
  end
  
  def default_image_sizes
    @article = Article.find(params[:id])
  end
  
  def preview
    @article = Article.find(params[:id])
  end
  
  private

  def resolve_layout
    case action_name
    when "default_image_sizes"
      "admin_popup"
    else
      "admin"
    end
  end
end
