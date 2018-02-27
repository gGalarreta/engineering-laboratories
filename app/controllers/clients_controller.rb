class ClientsController < ApplicationController

  before_action :set_client, only: [:edit, :update, :show, :toggle_status]

  def index
    @clients = User.client
  end

  def new
    @client = User.new
  end

  def create
    @client = User.new client_params
    if @client.save
      Audit.register current_user, @action, @controller, register_status = true
      redirect_to clients_path
    else
      Audit.register current_user, @action, @controller, register_status = false
      render :new
    end
  end

  def edit
  end

  def update
    if @client.update_attributes client_params
      Audit.register current_user, @action, @controller, register_status = true
      redirect_to clients_path
    else
      Audit.register current_user, @action, @controller, register_status = false
      render :edit
    end
  end

  def show
  end

  def toggle_status
    @client.change_status
    Audit.register current_user, @action, @controller, register_status = true
    respond_to do |format|
      format.js
    end
  end   

  private

    def client_params
      params.require(:user).permit(:id, :first_name, :last_name, :ruc, :contact_person, :phone, :address).merge(category: User.categories["client"])
    end

    def set_client
      @client = User.find params[:id]
    end
end
