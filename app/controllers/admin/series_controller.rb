class Admin::SeriesController < Admin::AdminController
  
  def index
    @serieses = Series.all
    @series = Series.new
  end
  
  def edit
    @series = Series.find(params[:id])
    @serieses = Series.all
  end
    
  def new
    @series = Series.new
    @serieses = Series.all
  end
    
  def create
    @series = Series.create(params[:series])
    @serieses = Series.where(true)
    if @series.save
      flash[:alert] = "Series successfully created"
      redirect_to edit_admin_series_path(@series)
    else
      flash[:alert] = "All fields are required"
      render :new
    end
  end
  
  def update
    @series = Series.find(params[:id])
    @serieses.update_attributes(params[:series])
    if @series.save
      @serieses = Series.where(true)
      flash[:alert] = "Series successfully updated"
      redirect_to edit_admin_series_path(@series)
    else
      flash[:alert] = "All fields are required"
      render :edit
    end
  end
  
  
end
