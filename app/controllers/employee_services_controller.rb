class EmployeeServicesController < ApplicationController
  
  before_action :set_service, only: [:show]

  def index
    @services = Service.belongs_work_environment current_user
  end

  def show
  end

  private
    def set_service
      @service = Service.find params[:id]
    end

end
