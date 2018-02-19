class EmployeesController < ApplicationController

  before_action :set_employee, only: [:edit, :update, :show]
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
      redirect_to employees_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @employee.update_attributes employee_params
      redirect_to employees_path
    else
      render :edit
    end
  end

  def show
  end


  private

  def employee_params
    params.require(:user).permit(:id, :first_name, :last_name, :address, :phone, :date_of_birth, :gender, :laboratory_id, :role_id, :email).merge(category: User.categories["employee"])
  end

  def set_employee
    @employee = User.find params[:id]
  end

  def laboratories
    @laboratories = Laboratory.all
  end

  def roles
    @roles = Role.belongs_work_environment current_user
  end
end
