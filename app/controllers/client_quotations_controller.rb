class ClientQuotationsController < ApplicationController

  before_action :set_service, only: [:edit, :update]
  before_action :sample_categories, only: [:edit, :update]
  before_action :sample_methods, only: [:edit, :update]
  before_action :set_terms_and_condition, only: [:edit, :update]

  def index
    @funded_services = Service.funded_services current_user
    @adjusted_services = Service.adjusted_services current_user
    @pending_services = Service.pending_services current_user
  end

  def edit
  end

  def update
    @service.update_and_set_next_step quotation_params, current_user
    if @service.save
      redirect_to client_quotations_path
    else
      render :edit
    end
  end

  private

    def quotation_params
      params.require(:service).permit(:funded_validation, :engagement, costing_comments_attributes: costing_comments_params)
    end

    def costing_comments_params
      [:id, :description, :_destroy]
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
  
    def set_terms_and_condition
      @terms_and_condition = SystemParameter.get_terms_and_condition_in_our_environment @service
    end
end
