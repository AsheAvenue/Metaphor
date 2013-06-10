class ArticlesController < ApplicationController

  def index
  end
  
  def show
    @article = Article.find(params[:id])
  end
  
  def preview
    @article = Article.find(params[:id])
    @preview = true
    render :show
  end

end
