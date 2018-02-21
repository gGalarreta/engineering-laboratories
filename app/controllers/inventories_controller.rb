class InventoriesController < ApplicationController

  before_action :set_inventory, only: [:show, :edit, :update, :destroy]
  before_action :laboratories, only: [:new, :create, :edit, :update, :show]


  def index
    @inventories = Inventory.belongs_work_environment current_user
    @supplies = Supply.belongs_work_environment current_user
  end

  def new
    @inventory = Inventory.new
  end

  def create
    @inventory = Inventory.new inventory_params
    if @inventory.save
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
    @inventory.assign_attributes inventory_params
    if @inventory.save
      Audit.register current_user, @action, @controller, register_status = true
      redirect_to inventories_path
    else
      Audit.register current_user, @action, @controller, register_status = false
      render :new
    end
  end

  def destroy
    @inventory.destroy
    if @inventory.destroy
      Audit.register current_user, @action, @controller, register_status = true
      redirect_to inventories_path
    else
      Audit.register current_user, @action, @controller, register_status = false
      redirect_to inventories_path
    end
  end

  def toggle_status
    @inventory.change_status
    Audit.register current_user, @action, @controller, register_status = true
    respond_to do |format|
      format.js
    end
  end

  private

  def inventory_params
    params.require(:inventory).permit(:laboratory_id, :code, :name, :brand, :product_model, :amount, :description, :date_of_entry)
  end

  def set_inventory
    @inventory = Inventory.find(params[:id])
  end

  def laboratories
    @laboratories = Laboratory.only_actives
  end

end
