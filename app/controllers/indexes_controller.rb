class IndexesController < ApplicationController

  def index
  end
  
  def preview
    @preview = true
    render :index
  end

end
