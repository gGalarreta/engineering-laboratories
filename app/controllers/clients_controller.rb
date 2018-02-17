class ClientsController < ApplicationController

  before_action :set_client, only: [:edit, :update, :show]

  def index
    @clients = User.client
  end

  def new
    @client = User.new
  end

  def create
    @client = User.new client_params
    if @client.save
      redirect_to clients_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @client.update_attributes client_params
      redirect_to clients_path
    else
      render :edit
    end
  end

  def show
  end

  private

    def client_params
      params.require(:user).permit(:id, :first_name, :last_name, :ruc, :contact_person, :phone, :address).merge(category: User.categories["client"])
    end

    def set_client
      @client = User.find params[:id]
    end
end
