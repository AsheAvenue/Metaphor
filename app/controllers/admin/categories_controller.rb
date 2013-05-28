class Admin::CategoriesController < Admin::AdminController
  
  def index
    @categories = Category.all
    @category = Category.new
  end
    
  def create
    category = Category.create(params[:category])
    category.save
    redirect_to admin_categories_path
  end
  
  def show
    @category = Category.find(params[:id])
  end
  
  def update
    category = Category.find(params[:id])
    category.update_attributes(params[:category])
    category.save
    redirect_to admin_categories_path
  end
  
end
