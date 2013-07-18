module Metaphor
  class UsersController < ApplicationController
  
    def index
      @users = User.where(true)
      @users = @users.alphabetical
    end
  
    def show
      @user = User.find(params[:id])
      redirect_to edit_user_path(@user)
    end

    def edit
      @user = User.find(params[:id])
      @users = User.where(true)
      @users = @users.alphabetical
    end
  
    def new
      @user = User.new
      @users = User.where(true)
      @users = @users.alphabetical
    end

    def create
      @user = User.new(params[:user])
      @users = User.where(true)
      @users = @users.alphabetical
      if @user.save
        flash[:alert] = "User successfully created"
        redirect_to edit_user_path(@user)
      else
        flash[:alert] = "All fields are required"
        render :new
      end
    end
  
    def update
      @user = User.find(params[:id])
      @user.update_attributes(params[:user])
      if @user.save
        @users = User.where(true)
        @users = @users.alphabetical
        flash[:alert] = "User successfully updated"
        redirect_to edit_user_path(@user)
      else
        flash[:alert] = "All fields are required"
        render :edit
      end
    end
  
  end
end
