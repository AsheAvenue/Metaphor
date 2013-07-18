require_dependency "metaphor/application_controller"

module Metaphor
  class SessionsController < ApplicationController
  
    skip_before_filter :require_login #otherwise we'd have an infinite loop
    skip_load_and_authorize_resource #don't let cancan try and instantiate a non-existent "Picker" resource
    
    layout 'metaphor/auth'
  
    def new
    end

    def create
      user = login(params[:username], params[:password], params[:remember_me])
      if user
        redirect_back_or_to metaphor_path
      else
        flash[:alert] = "Invalid username or password"
        render :new
      end
    end
  
    def destroy
      logout
      redirect_to metaphor_path
    end
  
  end
end