class SupervisorCustodyOrdersController < ApplicationController

  before_action :set_custody_order, only: [:custody_check, :custody_check_update]
  before_action :set_service_belongs_to_custody_order, only: [:custody_check, :custody_check_update]
  before_action :set_processed_sample, only: [:custody_check, :custody_check_update]
  before_action :set_preliminary_order, only: [:custody_check, :custody_check_update]  
  before_action :set_service, only: [:edit, :update]
  before_action :set_employees, only: [:edit, :update, :custody_check, :custody_check_update]
  before_action :set_custody_table, only: [:custody_check]

  def index
    @services_unclassified = Service.unclassified_services current_user
    @custody_order_to_check = CustodyOrder.custody_orders_to_check current_user
  end

  def edit
  end


  def update
    @service.assign_worker_to_job params, current_user
    if @service.save
      redirect_to supervisor_custody_orders_path
    else
      render :edit
    end
  end

  def custody_check
  end

  def custody_check_update
    @custody_order.assign_attributes custody_order_supervision_params
    if @custody_order.update_order
      @service_belongs_to_custody_order
      redirect_to supervisor_custody_orders_path
    else
      render :custody_check
    end
  end

  private

    def custody_order_supervision_params
      params.require(:custody_order).permit(:supervised_validation)
    end

    def custody_order_params
      params.require(:custody_order).permit(:revision_number,:supervisor_observation,:supervised_validation, processed_sample_attributes: processed_samples_params)
    end

    def processed_samples_params
      [:id, :sample_category_id, :description, :pucp_code, :client_code]
    end

    def set_service
      @service = Service.find params[:id]
    end

    def set_custody_order
      @custody_order = CustodyOrder.find params[:id]
    end

    def set_service_belongs_to_custody_order
      @service_belongs_to_custody_order = @custody_order.service
    end

    def set_processed_sample
      @processed_sample = @custody_order.processed_sample
    end

    def set_preliminary_order
      @preliminary_order = @processed_sample.preliminary_order
    end

    def set_custody_table
      @rows = @preliminary_order.number_of_samples
      @cols = @preliminary_order.number_of_features      
    end

    def set_employees
      @employees = User.valid_workers_to_assign_job current_user
    end

end
