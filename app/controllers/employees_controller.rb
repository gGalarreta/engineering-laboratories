class EmployeesController < ApplicationController

  before_action :set_employee, only: [:edit, :update, :show, :toggle_status]
  before_action :laboratories, only: [:new, :create, :edit, :update]
  before_action :roles, only: [:new, :create, :edit, :update]

  def index
    @employees = User.belongs_work_environment current_user
  end

  def new
    @employee = User.new
  end

  def create
    @employee = User.initialize employee_params, current_user
    if @employee.save
      Audit.register current_user, @action, @controller, register_status = true
      redirect_to employees_path
    else
      Audit.register current_user, @action, @controller, register_status = false
      render :new
    end
  end

  def edit
  end

  def update
    if @employee.update_attributes employee_params
      Audit.register current_user, @action, @controller, register_status = true
      redirect_to employees_path
    else
      Audit.register current_user, @action, @controller, register_status = false
      render :edit
    end
  end

  def show
  end

  def toggle_status
    @employee.change_status
    Audit.register current_user, @action, @controller, register_status = true
    respond_to do |format|
      format.js
    end
  end   


  private

  def employee_params
    params.require(:user).permit(:id, :first_name, :last_name, :address, :phone, :date_of_birth, :gender, :laboratory_id, :role_id, :email).merge(category: User.categories["employee"])
  end

  def set_employee
    @employee = User.find params[:id]
  end

  def laboratories
    @laboratories = Laboratory.only_actives
  end

  def roles
    @roles = Role.belongs_work_environment current_user
  end
end
