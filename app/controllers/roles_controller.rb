class RolesController < ApplicationController

  before_action :menus, only: [:new, :create]

  def index
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

  private

  def menus
    @menus = Menu.all
  end

  def role_params
    params.require(:role).permit(:name, :description, menu_actions_attributes: menu_actions_params)
  end

  def menu_actions_params
    [:menu_id, :name, :create, :edit, :view, :status, :_destroy]
  end
end
