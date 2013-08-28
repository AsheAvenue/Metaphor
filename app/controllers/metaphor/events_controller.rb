module Metaphor
  class EventsController < MetaphorController
  
    layout 'metaphor/metaphor'
    
    def index
      @events = Event.all
      @event = Event.new
    end
  
    def edit
      @event = Event.find(params[:id])
      @events = Event.recently_updated.limit(10)
    end
    
    def new
      @event = Event.new
      @events = Event.recently_updated.limit(10)
    end
    
    def create    
      @event = Event.create(params[:event])
      @events = Event.where(true)
      if @event.save
        flash[:alert] = "#{Settings.events.name} successfully created"
        Rails.cache.clear
        redirect_to edit_event_path(@event)
      else
        flash[:alert] = "Please enter a Name, Slug, Type, and Date"
        render :new
      end
    end
  
    def update
      @event = Event.find(params[:id])
      # Open the url that's been returned by Filepicker.
      # Then remove the default image from params so it doesn't get updated 
      # via update_attributes, which will cause a validation error
      if  params[:event][:default_image_selected] == "true" && params[:event][:default_image] != '/default_images/original/missing.png'
        url = params[:event][:default_image]
        original_filename = params[:event][:default_image_original_filename]
        @event.default_image = open(url)
        @event.default_image.instance_write(:file_name, original_filename)
      end
      params[:event].delete :default_image
      
      # get events
      @events = Event.recently_updated.all
      @event.end_date = params[:event][:end_date]
      @event.date = params[:event][:date]
      if @event.end_date && (@event.end_date.midnight < @event.date.midnight)
        flash[:alert] = "End date must be greater than or equal to event date"
        @event.end_date = nil
        render :edit
      elsif @event.update_attributes(params[:event])
        Rails.cache.clear
        flash[:alert] = "#{Settings.events.name} successfully updated"
        redirect_to edit_event_path(@event)
      else
        flash[:alert] = "All fields are required"
        render :edit
      end
    end  
    
    def destroy
      event = Event.find_by_id(params[:id]).destroy
      Rails.cache.clear
      redirect_to events_path
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