class UsersController < ApplicationController
  
  layout 'auth'
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      login(params[:user][:username], params[:user][:password], false)
      redirect_to admin_url
    else
      flash[:alert] = "Fill in the form, sucka"
      render :new
    end
  end
end
