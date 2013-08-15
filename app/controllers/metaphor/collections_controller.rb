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
        @collections = Collection.where(true)
        redirect_to edit_collection_path(@collection)
      else
        flash[:alert] = "All fields are required"
        render :edit
      end
    end
  
    def sort
      params[:pinned_entities].each_with_index do |id, index|
        PinnedEntity.update_all({order: index+1}, {id: id})
      end 
      render nothing: true
    end
  
    def add_pinned_entity
      @collection = Collection.find(params[:id])
      @p = @collection.pinned_entities.build
      @p.entity_id = params[:entity_id]
      @p.entity_typ = params[:entity_type]
      @p.save!
    end
  
    def remove_pinned_entity
      @p = PinnedEntity.find(params[:pinned_entity_id])
      @p.destroy
    end
  
  end

end