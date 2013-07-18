module Metaphor
  class RelatedPartiesController < ApplicationController
  
    def index
      @related_parties = RelatedParty.all
      @related_party = RelatedParty.new
    end
  
    def edit
      @related_party = RelatedParty.find(params[:id])
      @related_parties = RelatedParty.all
    end
    
    def new
      @related_party = RelatedParty.new
      @related_parties = RelatedParty.all
    end
    
    def create    
      @related_party = RelatedParty.create(params[:related_party])
      @related_parties = RelatedParty.where(true)
      if @related_party.save
        flash[:alert] = "#{Settings.related_parties.singular} successfully created"
        redirect_to edit_related_party_path(@related_party)
      else
        flash[:alert] = "All fields are required"
        render :new
      end
    end
  
    def update
      @related_party = RelatedParty.find(params[:id])
      @related_party.update_attributes(params[:related_party])
      if @related_party.save
        @related_parties = RelatedParty.where(true)
        flash[:alert] = "#{Settings.related_parties.singular} successfully updated"
        redirect_to edit_related_party_path(@related_party)
      else
        flash[:alert] = "All fields are required"
        render :edit
      end
    end
  
  end

end