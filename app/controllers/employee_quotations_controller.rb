class EmployeeQuotationsController < ApplicationController

  before_action :set_service, only: [:edit, :update]
  before_action :sample_categories, only: [:edit, :update]
  before_action :sample_methods, only: [:edit, :update]

  def index
    @unfunded_services = Service.unfunded_services current_user
    @unadjusted_services = Service.worked_services current_user
    @contract_bound_services = Service.contract_bound_services current_user
  end

  def edit
  end
  
  def update
  end

  private
    def set_service
      @service = Service.find params[:id]
    end

    def sample_categories
      @sample_categories = SampleCategory.belongs_work_environment(current_user).only_actives
    end

    def sample_methods
      @sample_methods = SampleMethod.belongs_work_environment(current_user).only_actives
    end
end
