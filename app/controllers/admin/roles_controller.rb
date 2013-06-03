class Admin::RolesController < ApplicationController
  
  layout 'admin'
  before_filter :require_login
  
  def index
    @roles = Role.where(true)
    @roles = @roles.alphabetical
  end
  
  def show
    @roles = Role.find(params[:id])
    redirect_to edit_admin_role_path(@role)
  end

  def edit
    @role = Role.find(params[:id])
    @roles = Role.where(true)
    @roles = @roles.alphabetical
  end
  
  def new
    @role = Role.new
    @roles = Role.where(true)
    @roles = @roles.alphabetical
  end

  def create
    @role = Role.new(params[:role])
    @roles = Role.where(true)
    @roles = @roles.alphabetical
    if @role.save
      flash[:alert] = "Role successfully created"
      redirect_to edit_admin_role_path(@role)
    else
      flash[:alert] = "All fields are required"
      render :new
    end
  end
  
  def update
    @role = Role.find(params[:id])
    @role.update_attributes(params[:role])
    if @role.save
      @roles = Role.where(true)
      @roles = @roles.alphabetical
      flash[:alert] = "Role successfully updated"
      redirect_to edit_admin_role_path(@role)
    else
      flash[:alert] = "All fields are required"
      render :edit
    end
  end
  
end
