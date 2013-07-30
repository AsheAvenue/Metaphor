module Metaphor
  class FlagsController < ApplicationController
  
    layout 'metaphor/metaphor'
    
    def index
      @flags = Flag.all
      @flag = Flag.new
    end
  
    def edit
      @flag = Flag.find(params[:id])
      @flags = Flag.all
    end
    
    def new
      @flag = Flag.new
      @flags = Flag.all
    end
    
    def create    
      @flag = Flag.create(params[:flag])
      @flags = Flag.where(true)
      if @flag.save
        flash[:alert] = "#{Settings.flags.name} successfully created"
        redirect_to edit_flag_path(@flag)
      else
        flash[:alert] = "All fields are required"
        render :new
      end
    end
  
    def update
      @flag = Flag.find(params[:id])
      @flag.update_attributes(params[:flag])
      if @flag.save
        @flags = Flag.where(true)
        flash[:alert] = "#{Settings.flags.name} successfully updated"
        redirect_to edit_flag_path(@flag)
      else
        flash[:alert] = "All fields are required"
        render :edit
      end
    end
  
  end
end