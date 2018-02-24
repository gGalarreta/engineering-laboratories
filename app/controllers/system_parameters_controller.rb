class SystemParametersController < ApplicationController

  before_action :set_system_parameter, only: [:edit, :update, :show]
  before_action :laboratories, only: [:edit, :update, :show]

  def index
    @system_parameters = SystemParameter.belongs_work_environment current_user
    if current_user.admin? then
      @laboratories = Laboratory.only_actives
    else
      @laboratories = Laboratory.where(laboratory_id: current_user.laboratory)
    end
  end

  def show
  end

  def edit
  end

  def update
    @system_parameter.assign_attributes system_parameter_params
    if @system_parameter.save
       Audit.register current_user, @action, @controller, register_status = true
       redirect_to system_parameters_path
    else
       Audit.register current_user, @action, @controller, register_status = false
       render :edit
    end
  end

  private

    def system_parameter_params
      params.require(:system_parameter).permit(:laboratory_id, :description)
    end

    def set_system_parameter
      @system_parameter = SystemParameter.find params[:id]
    end

    def laboratories
      if current_user.admin? then
        @laboratories = Laboratory.only_actives
      else
        @laboratories = Laboratory.where(laboratory_id: current_user.laboratory)
      end
    end
end
