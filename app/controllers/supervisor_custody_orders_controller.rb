class SupervisorCustodyOrdersController < ApplicationController

  before_action :set_custody_order, only: [:custody_check,:custody_check_update]
  before_action :set_custody_table, only: [:custody_check]
  before_action :set_service, only: [:edit,:update]
  before_action :set_employees, only: [:edit, :update]

  def index
    @services_unclassified = Service.unclassified_services current_user
    @custody_order_to_check = CustodyOrder.custody_orders_to_check current_user
  end

  def edit
  end

  def custody_check
  end

  def update
    @service.asssign_workers_custody params, current_user
    @service.set_next_step current_user
    if @service.save
      redirect_to supervisor_custody_orders_path
    else
      render :edit
    end
  end

  def custody_check_update
    begin
      @custody_order.assign_validation params
      @custody_order.handling_internal_process(current_user)
      if CustodyOrder.custody_orders_per_service(@service).where.not(custody_progress: "completed").length == 0
        @service.set_next_step current_user
        @service.save
      end
      if @custody_order.to_reclassify?
        @custody_order.increment!(:revision_number)
      end
      redirect_to supervisor_custody_orders_path
    end
  end

  private

    def custody_order_params
      params.require(:custody_order).permit(:revision_number,:supervisor_observation,:supervised_validation, processed_sample_attributes: processed_samples_params)
    end

    def processed_samples_params
      [:id, :sample_category_id, :description, :pucp_code, :client_code]
    end

    def set_service
      @service = Service.find params[:id]
      @custody_orders = CustodyOrder.where(service_id: params[:id])
    end

    def set_custody_order
      @custody_order = CustodyOrder.find params[:id]
      @processed_sample = @custody_order.processed_sample
      @preliminary_order = @processed_sample.preliminary_order
      @service = @custody_order.service
    end

    def set_custody_table
      @rows = @preliminary_order.quantity
      sample_id = @preliminary_order.sample_category_id
      method_id = @preliminary_order.sample_method_id
      cross_table = SamplesCategoryMethod.where(sample_category_id: sample_id).where(sample_method_id: method_id).first
      @features = Feature.where(samples_category_method_id: cross_table.id)
      @cols = @features.pluck(:description)
    end

    def set_employees
      @employees = User.valid_workers_to_assign_job current_user
    end

end
