module Metaphor
  class UsersController < MetaphorController
  
    layout 'metaphor/metaphor'
    
    def index
      @users = User.alphabetical
    end
  
    def show
      @user = User.find(params[:id])
      redirect_to edit_user_path(@user)
    end

    def edit
      @user = User.find(params[:id])
      @users = User.alphabetical
    end
  
    def new
      @user = User.new
      @users = User.alphabetical
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
        redirect_to new_user_path
      end
    end
  
    def update
      @user = User.find(params[:id])
      if @user.update_attributes(params[:user])
        flash[:alert] = "User successfully updated"
      else
        flash[:alert] = "All fields are required"
      end
      redirect_to edit_user_path(@user)
    end
  
  end
end
