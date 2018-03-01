class EmployeeServicesController < ApplicationController
  
  before_action :set_service, only: [:show]

  def index
    @services = Service.belongs_work_environment current_user
  end

  def show
  end

  def search
    start_date = params[:start_date].to_date.strftime("%m/%d/%Y")
    end_date = params[:end_date].to_date.strftime("%m/%d/%Y")
    @services = Service.advanced_search(start_date, end_date)
  end  

  private
    def set_service
      @service = Service.find params[:id]
    end

end
