module Metaphor
  class CollectionsController < ApplicationController

    layout 'metaphor/metaphor'
    
    def index
      @collections = Collection.all
      @collection = Collection.new
    end
  
    def edit
      @collection = Collection.find(params[:id])
      if !@collection.content_type
        @collection.content_type = 'article'
      end
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
        flash[:alert] = "#{Settings.collections.name} successfully created"
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
        
        update_collection_cache(@collection)

        @collections = Collection.where(true)
        redirect_to edit_collection_path(@collection)
      else
        flash[:alert] = "All fields are required"
        render :edit
      end
    end
  
    def sort
      collection = Collection.unscoped.find(params[:id])
      params[:pinned_entities].each_with_index do |id, index|
        PinnedEntity.update_all({order: index+1}, {id: id})
      end 
      update_collection_cache(collection)
      render nothing: true
    end
  
    def add_pinned_entity
      @collection = Collection.find(params[:id])
      @p = @collection.pinned_entities.build
      @p.entity_type = params[:entity_type]
      @p.entity_id = params[:entity_id].to_i
      @p.save!
      update_collection_cache(@collection)
    end
  
    def remove_pinned_entity
      @p = PinnedEntity.find(params[:pinned_entity_id])
      collection = @p.collection
      update_collection_cache(@p.collection)
      @p.destroy
    end
    
    private 
    
    def update_collection_cache(collection)
      Rails.cache.delete("collection_#{collection.slug}")
      
      loops = Article.published.count / Settings.site.pagination.default
      loops.times do |i|
        Rails.cache.delete("homepage_all_#{i}")
        Rails.cache.delete("homepage_hottest_#{i}")
        Rails.cache.delete("homepage_pagination_#{i}")
        Rails.cache.delete("category_pagination_#{i}")
        Rails.cache.delete("flag_pagination_#{i}")
      end
      
    end
  
  end

end