class EmployeeCustodyOrdersController < ApplicationController

  before_action :set_custody_order, only: [:edit, :update]
  before_action :set_processed_sample, only: [:edit, :update]
  before_action :set_preliminary_order, only: [:edit, :update]
  before_action :set_custody_table, only: [:values, :edit, :update]

  def index
    @custody_orders_to_classified = CustodyOrder.custody_orders_to_classified current_user
    @custody_orders_to_reclassify = CustodyOrder.custody_orders_to_reclassify current_user
  end

  def values
    #@lower_range = @features.pluck(:lower_range)
    #@upper_range = @features.pluck(:upper_range)
    respond_to do |format|
      format.js
    end
  end

  def edit
  end

  def update
    @processed_sample.update_order params, @preliminary_order
    if @custody_order.update_order
      redirect_to employee_custody_orders_path
    else
      render :edit
    end
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
end
