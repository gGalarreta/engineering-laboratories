class SuppliesController < ApplicationController

  before_action :set_supply, only: [:show, :edit, :update, :destroy, :toggle_status]
  before_action :laboratories, only: [:new, :create, :edit, :update, :show]
  before_action :set_controller


  def index
    @supplies = Supply.belongs_work_environment current_user
  end

  def new
    @supply = Supply.new
  end

  def show
  end

  def create
    @supply = Supply.new supply_params
    if @supply.save
      Audit.register current_user, @action, @controller, register_status = true
      redirect_to inventories_path
    else
      Audit.register current_user, @action, @controller, register_status = false
      render :new
    end
  end

  def edit
  end

  def update
    @supply.assign_attributes supply_params
    if @supply.save
      Audit.register current_user, @action, @controller, register_status = true
      redirect_to inventories_path
    else
      Audit.register current_user, @action, @controller, register_status = false
      render :edit
    end
  end

  def destroy
    @supply.destroy
    if @supply.destroy
      Audit.register current_user, @action, @controller, register_status = true
      redirect_to inventories_path
    end
  end

  def toggle_status
    @supply.change_status
    Audit.register current_user, @action, @controller, register_status = true
    respond_to do |format|
      format.js
    end
  end

  private
    def supply_params
      params.require(:supply).permit(:laboratory_id, :code, :name, :description, :quantity, :measureUnit)
    end

    def set_supply
      @supply = Supply.find(params[:id])
    end

     def laboratories
      @laboratories = Laboratory.only_actives
    end

    def set_controller
      @controller = "inventories"
  end
end
