class SessionsController < ApplicationController
  
  layout 'auth'
  
  def new
  end

  def create
    user = login(params[:username], params[:password], params[:remember_me])
    if user
      redirect_back_or_to admin_path
    else
      flash[:alert] = "Invalid username or password"
      render :new
    end
  end
  
  def destroy
    logout
    redirect_to "/"
  end
  
end