module Metaphor
  class SeriesController < MetaphorController

    layout 'metaphor/metaphor'
    
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
        flash[:alert] = "#{Settings.series.name} successfully created"
        redirect_to edit_series_path(@series)
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
        flash[:alert] = "#{Settings.series.name} successfully updated"
        redirect_to edit_series_path(@series)
      else
        flash[:alert] = "All fields are required"
        render :edit
      end
    end
    
  end

end