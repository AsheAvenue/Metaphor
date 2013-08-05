module Metaphor
  class EventsController < ApplicationController
  
    layout 'metaphor/metaphor'
    
    def index
      @events = Event.all
      @event = Event.new
    end
  
    def edit
      @event = Event.find(params[:id])
      @events = Event.all
    end
    
    def new
      @event = Event.new
      @events = Event.all
    end
    
    def create    
      @event = Event.create(params[:event])
      @events = Event.where(true)
      if @event.save
        flash[:alert] = "#{Settings.events.name} successfully created"
        redirect_to edit_event_path(@event)
      else
        flash[:alert] = "All fields are required"
        render :new
      end
    end
  
    def update
      @event = Event.find(params[:id])
      @event.update_attributes(params[:event])
      if @event.save
        @events = Event.where(true)
        flash[:alert] = "#{Settings.events.name} successfully updated"
        redirect_to edit_event_path(@event)
      else
        flash[:alert] = "All fields are required"
        render :edit
      end
    end
    
    def taglist
      render json: Event.tag_counts_on(:tags)
                   .where("name ilike ?","%#{params[:term]}%")
                   .order("name ilike '%#{params[:term]}%' DESC, LENGTH(name) ASC, name ASC")
                   .map(&:to_s)
                   .map(&:downcase)
    end
    
    def related_entity_list
      entity = params[:related_entity]
      render json: entity
                   .constantize
                   .select("name as value, id as id")
                   .where("name ilike ?","%#{params[:term]}%")
                   .order("name ilike '%#{params[:term]}%' DESC, LENGTH(name) ASC, name ASC")
    end
  
  end
end