class EmployeeCustodyOrdersController < ApplicationController

  before_action :set_custody_order, only: [:edit, :update]
  before_action :set_custody_table, only: [:values,:edit,:update]

  def index
    @custody_orders_to_classified = CustodyOrder.custody_orders_to_classified current_user
    @custody_orders_to_reclassify = CustodyOrder.custody_orders_to_reclassify current_user
  end

  def values
    @lower_range = @features.pluck(:lower_range)
    @upper_range = @features.pluck(:upper_range)
    respond_to do |format|
      format.js
    end
  end

  def update
    @processed_sample.update_params params,@preliminary_order
    if @custody_order.to_reclassify?
      @custody_order.supervisor_observation = params[:custody_order][:supervisor_observation]
    end
    @custody_order.handling_internal_process current_user
    redirect_to employee_custody_orders_path
  end

  private

    def custody_order_params
      params.require(:custody_order).permit(:supervisor_id,:employee_id,:revision_number,:supervisor_observation,:supervised_validation,processed_sample_attributes: processed_sample_params)
    end

    def processed_sample_params
      [:id, :client_code, :pucp_code, :description]
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
end
