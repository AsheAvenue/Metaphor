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
    @templates = []
    Settings.templates.each do |template|
      t = Hash[ [:name, :image, :components].zip(template[1].split('*',3)) ]
      t[:key] = template[0];
      @templates.push t
    end
  end

  def new
    @articles = Article.where(true).newest
    @article = Article.new
  end
  
  def create
    article = Article.create(params[:article])
    article.save!
    redirect_to admin_articles_path
  end
  
  def update
    article = Article.find(params[:id])
    article.update_attributes(params[:article])
    article.save
    redirect_to edit_admin_article_path(params[:id])
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
