module Metaphor
  class PagesController < ApplicationController
  
    layout 'metaphor/metaphor'
    
    def index
      @pages = Page.all
      @page = Page.new
    end
  
    def edit
      @page = Page.find(params[:id])
      @pages = Page.all
    end
    
    def new
      @page = Page.new
      @pages = Page.all
    end
    
    def create    
      @page = Page.create(params[:page])
      @pages = Page.all
      if @page.save
        flash[:alert] = "#{Settings.pages.name} successfully created"
        redirect_to edit_page_path(@page)
      else
        flash[:alert] = "All fields are required"
        render :new
      end
    end
  
    def update
      @page = Page.find(params[:id])
      @page.update_attributes(params[:page])
      if @page.save
        @pages = Page.all
        flash[:alert] = "#{Settings.pages.name} successfully updated"
        Rails.cache.delete("page_#{@page.slug}")
        redirect_to edit_page_path(@page)
      else
        flash[:alert] = "All fields are required"
        render :edit
      end
    end
  
  end
end