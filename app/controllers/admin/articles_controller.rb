class Admin::ArticlesController < Admin::AdminController
  def index
    @articles = Article.all
  end

  def show
    @articles = Article.all
    @article = Article.find(params[:id])
  end

  def new
    @articles = Article.all
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
    redirect_to admin_articles_path
  end
  
  def checkslug
    article = Article.find_by_slug(params[:slug])
    if article
      render :text => 'TRUE'
    else
      render :text => 'FALSE'
    end
  end
  
end
