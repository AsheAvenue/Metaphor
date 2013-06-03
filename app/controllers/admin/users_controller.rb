class Admin::UsersController < ApplicationController
  
  layout 'admin'
  before_filter :require_login
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    redirect_to edit_admin_user_path(@user)
  end

  def edit
    @user = User.find(params[:id])
    @users = User.all
  end
  
  def new
    @user = User.new
    @users = User.all
  end

  def create
    @user = User.new(params[:user])
    @users = User.all
    if @user.save
      flash[:alert] = "User successfully created"
      redirect_to edit_admin_user_path(@user)
    else
      flash[:alert] = "All fields are required"
      render :new
    end
  end
  
  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    if @user.save
      @users = User.all
      flash[:alert] = "User successfully updated"
      redirect_to edit_admin_user_path(@user)
    else
      flash[:alert] = "All fields are required"
      render :edit
    end
  end
  
end
