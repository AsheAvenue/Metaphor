module Metaphor
  class PagesController < ApplicationController
  
    skip_load_and_authorize_resource
    # TODO: load_and_authorize_resource :pages, :find_by => :slug, :id_param => :slug
    
    def index
      @pages = Page.all
      @page = Page.new
    end
  
    def edit
      @page = Page.find_by_slug!(params[:id])
      @pages = Page.all
    end
    
    def new
      @page = Page.new
      @pages = Page.all
    end
    
    def create    
      @page = Page.create(params[:page])
      @pages = Page.where(true)
      if @page.save
        flash[:alert] = "#{Settings.pages.singular} successfully created"
        redirect_to edit_page_path(@page)
      else
        flash[:alert] = "All fields are required"
        render :new
      end
    end
  
    def update
      @page = Page.find_by_slug!(params[:id])
      @page.update_attributes(params[:page])
      if @page.save
        @pages = Page.where(true)
        flash[:alert] = "#{Settings.pages.singular} successfully updated"
        redirect_to edit_page_path(@page)
      else
        flash[:alert] = "All fields are required"
        render :edit
      end
    end
  
  end
end