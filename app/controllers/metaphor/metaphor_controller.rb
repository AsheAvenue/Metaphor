module Metaphor
  class MetaphorController < ActionController::Base
    
    layout 'metaphor/metaphor'
    
    before_filter :require_login
    protect_from_forgery
    load_and_authorize_resource
    
    private
  
    def not_authenticated
      redirect_to signin_url
    end
    
  end
end
