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
    if @custody_order.update_order current_user
      @service_belongs_to_custody_order.update_progress_if_finish current_user
      redirect_to supervisor_custody_orders_path
    else
      render :custody_check
    end
  end

  private

    def custody_order_supervision_params
      params.require(:custody_order).permit(:supervised_validation, revision_comments_attributes: revision_comments_params)
    end

    def revision_comments_params
      [:id, :description, :_destroy]
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
