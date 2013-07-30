module Metaphor
  class CategoriesController < ApplicationController
  
    layout 'metaphor/metaphor'
    
    def index
      @categories = Category.all
      @category = Category.new
    end
  
    def edit
      @category = Category.find(params[:id])
      @categories = Category.all
    end
    
    def new
      @category = Category.new
      @categories = Category.all
    end
    
    def create    
      @category = Category.create(params[:category])
      @categories = Category.where(true)
      if @category.save
        flash[:alert] = "#{Settings.categories.name} successfully created"
        redirect_to edit_category_path(@category)
      else
        flash[:alert] = "All fields are required"
        render :new
      end
    end
  
    def update
      @category = Category.find(params[:id])
      @category.update_attributes(params[:category])
      if @category.save
        @categories = Category.where(true)
        flash[:alert] = "#{Settings.categories.name} successfully updated"
        redirect_to edit_category_path(@category)
      else
        flash[:alert] = "All fields are required"
        render :edit
      end
    end
  
  end
end