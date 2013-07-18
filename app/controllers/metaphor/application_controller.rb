module Metaphor
  class ApplicationController < ActionController::Base
    
    before_filter :require_login
    protect_from_forgery
    load_and_authorize_resource
    
    layout 'metaphor/metaphor'
    
    private
  
    def not_authenticated
      redirect_to signin_url
    end
    
  end
end
