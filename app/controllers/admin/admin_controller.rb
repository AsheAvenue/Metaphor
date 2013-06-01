class Admin::AdminController < ApplicationController
  layout 'admin'
  before_filter :require_login
  
  private
  
  def not_authenticated
    redirect_to signin_url
  end
    
end
