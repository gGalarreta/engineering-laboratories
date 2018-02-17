class RolesController < ApplicationController

  before_action :menus, only: [:new, :create, :edit, :update]
  before_action :set_role, only: [:edit, :update, :show]

  def index
    @roles = Role.all
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new role_params
    if @role.valid
      redirect_to roles_path
    else
      #p @role.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    @role.assign_attributes role_params
    if @role.valid
      redirect_to roles_path
    else
      render :edit
    end
  end

  def show
    
  end

  private

  def menus
    @menus = Menu.all
  end

  def role_params
    params.require(:role).permit(:id, :name, :description, menu_actions_attributes: menu_actions_params)
  end

  def menu_actions_params
    [:id, :menu_id, :name, :create, :edit, :view, :status, :_destroy]
  end

  def set_role
    @role = Role.find params[:id]
  end
end
