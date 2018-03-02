class EmployeeQuotationsController < ApplicationController

  before_action :set_service, only: [:edit, :update]
  before_action :sample_categories, only: [:edit, :update]
  before_action :sample_methods, only: [:edit, :update]

  def index
    @unfunded_services = Service.unfunded_services current_user
    @unadjusted_services = Service.worked_services current_user
    @contract_bound_services = Service.contract_bound_services current_user
    @pending_services = Service.pending_services current_user
  end

  def edit
  end
  
  def update
    @service.update_and_set_next_step quotation_params, current_user
    if @service.save
      redirect_to employee_quotations_path
    else
      render :edit
    end
  end

  def get_sample_methods
    respond_to do |format|
      format.json {
        render json: {sample_methods: SampleCategory.find(params[:id]).sample_methods}
      }
    end
  end

  def get_sample_method
    respond_to do |format|
      format.json {
        render json: {sample_method: SampleMethod.find(params[:id])}
      }
    end
  end  

  private

    def quotation_params
      params.require(:service).permit(:total, preliminary_orders_attributes: preliminary_orders_params)
    end

    def preliminary_orders_params
      [:id, :name, :quantity, :description, :sample_method_id, :sample_category_id, :unit_cost]
    end

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
