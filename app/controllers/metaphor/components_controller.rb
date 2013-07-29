module Metaphor
  class ComponentsController < ApplicationController

    def index
      @components = Component.all
      @component = Component.new
    end
  
    def edit
      @component = Component.find(params[:id])
      @components = Component.all
    end
    
    def new
      @component = Component.new
      @components = Component.all
    end
    
    def create    
      @component = Component.create(params[:component])
      @components = Component.where(true)
      if @component.save
        flash[:alert] = "#{Settings.components.name} successfully created"
        redirect_to edit_component_path(@component)
      else
        flash[:alert] = "All fields are required"
        render :new
      end
    end
  
    def update
      @component = Component.find(params[:id])
      @component.update_attributes(params[:component])
      if @component.save
        @components = Component.where(true)
        flash[:alert] = "#{Settings.components.name} successfully updated"
        redirect_to edit_component_path(@component)
      else
        flash[:alert] = "All fields are required"
        render :edit
      end
    end
  
  end

end