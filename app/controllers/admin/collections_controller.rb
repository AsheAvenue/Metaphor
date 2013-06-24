class Admin::CollectionsController < Admin::AdminController
  
  def index
    @collections = Collection.all
    @collection = Collection.new
  end
  
  def edit
    @collection = Collection.find(params[:id])
    @collections = Collection.all
    @collection.pinned_articles.new
  end
    
  def new
    @collection = Collection.new
    @collections = Collection.all
    @collection.pinned_articles.new
  end
    
  def create    
    @collection = Collection.create(params[:collection])
    @collections = Collection.where(true)
    if @collection.save
      flash[:alert] = "#{Settings.collections.singular} successfully created"
      redirect_to edit_admin_collection_path(@collection)
    else
      flash[:alert] = "All fields are required"
      render :new
    end
  end
  
  def update
    @collection = Collection.find(params[:id])
    @collection.update_attributes(params[:collection])
    if @collection.save
      @collections = Collection.where(true)
      flash[:alert] = "#{Settings.collections.singular} successfully updated"
      redirect_to edit_admin_collection_path(@collection)
    else
      flash[:alert] = "All fields are required"
      render :edit
    end
  end
  
end
