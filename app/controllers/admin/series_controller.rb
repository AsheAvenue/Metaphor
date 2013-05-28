class Admin::SeriesController < Admin::AdminController
  
  def index
    @series = Series.all
    @new_series = Series.new
  end
    
  def create
    series = Series.create(params[:series])
    series.save
    redirect_to admin_series_index_path
  end
  
  def show
    @series = Series.find(params[:id])
  end
  
  def update
    series = Series.find(params[:id])
    series.update_attributes(params[:series])
    series.save
    redirect_to admin_series_index_path
  end
  
end
