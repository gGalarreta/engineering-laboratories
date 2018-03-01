class ClientServicesController < ApplicationController

  before_action :laboratories, only: [:new, :create, :show, :edit, :update]
  before_action :set_service, only: [:show]

  def index
    @services = Service.belongs_to_client current_user
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.initialize service_params, current_user
    if @service.save
      redirect_to client_services_path
    else
      render :new
    end
  end

  def show
  end

  def search
    start_date = params[:start_date].to_date.strftime("%m/%d/%Y")
    end_date = params[:end_date].to_date.strftime("%m/%d/%Y")
    @services = Service.advanced_search(start_date, end_date)
  end

  private
    def laboratories
      @laboratories = Laboratory.only_actives
    end

    def service_params
      params.require(:service).permit(:laboratory_id, :pick_up_date, :subject, preliminary_orders_attributes: preliminary_order_params)
    end

    def preliminary_order_params
      [:id, :name, :quantity, :description]
    end

    def set_service
      @service = Service.find params[:id]
    end


end
