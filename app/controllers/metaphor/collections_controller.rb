module Metaphor
  class CollectionsController < ApplicationController

    def index
      @collections = Collection.all
      @collection = Collection.new
    end
  
    def edit
      @collection = Collection.find(params[:id])
      @collections = Collection.all
    end
    
    def new
      @collection = Collection.new
      @collections = Collection.all
    end
    
    def create    
      @collection = Collection.create(params[:collection])
      @collections = Collection.where(true)
      if @collection.save
        flash[:alert] = "#{Settings.collections.singular} successfully created"
        redirect_to edit_collection_path(@collection)
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
        redirect_to edit_collection_path(@collection)
      else
        flash[:alert] = "All fields are required"
        render :edit
      end
    end
  
    def sort
      params[:pinned_articles].each_with_index do |id, index|
        PinnedArticle.update_all({order: index+1}, {id: id})
      end 
      render nothing: true
    end
  
    def add_pinned_article
      @collection = Collection.find(params[:id])
      @p = @collection.pinned_articles.build
      @p.article_id = params[:article_id]
      @p.save!
    end
  
    def remove_pinned_article
      @p = PinnedArticle.find(params[:pinned_article_id])
      @p.destroy
    end
  
  end

end