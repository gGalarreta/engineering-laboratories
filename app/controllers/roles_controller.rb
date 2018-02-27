class RolesController < ApplicationController

  before_action :set_role, only: [:edit, :update, :show, :toggle_status]
  before_action :menus, only: [:new, :create, :edit, :update]
  before_action :laboratories, only: [:new, :create, :edit, :update]

  def index
    @roles = Role.belongs_work_environment current_user
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.initialize role_params, current_user
    if @role.valid
      Audit.register current_user, @action, @controller, register_status = true
      redirect_to roles_path
    else
      Audit.register current_user, @action, @controller, register_status = false
      render :new
    end
  end

  def edit
  end

  def update
    @role.assign_attributes role_params
    if @role.valid
      Audit.register current_user, @action, @controller, register_status = true
      redirect_to roles_path
    else
      Audit.register current_user, @action, @controller, register_status = false
      render :edit
    end
  end

  def show
  end

  def toggle_status
    @role.change_status
    Audit.register current_user, @action, @controller, register_status = true
    respond_to do |format|
      format.js
    end
  end   

  private

    def menus
      @menus = Menu.all
    end

    def role_params
      params.require(:role).permit(:id, :name, :description, :laboratory_id, menu_actions_attributes: menu_actions_params)
    end

    def menu_actions_params
      [:id, :menu_id, :name, :create, :edit, :view, :status, :_destroy]
    end

    def set_role
      @role = Role.find params[:id]
    end

    def laboratories
      @laboratories = Laboratory.only_actives
    end
end
