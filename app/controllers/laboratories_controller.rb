class LaboratoriesController < ApplicationController

  before_action :set_laboratory, only: [:edit, :update, :show, :toggle_status]

  def index
    @laboratories = Laboratory.all
  end

  def new
    @laboratory = Laboratory.new
  end

  def create
    @laboratory = Laboratory.new laboratory_params
    if @laboratory.save
      redirect_to laboratories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @laboratory.update_attributes laboratory_params
      redirect_to laboratories_path
    else
      render :edit
    end
  end

  def show
  end

  def toggle_status
    @laboratory.change_status
    respond_to do |format|
      format.js
    end
  end  

  private

  def laboratory_params
    params.require(:laboratory).permit(:id, :name, :email, :address, :phone, :description)
  end

  def set_laboratory
    @laboratory = Laboratory.find params[:id]
  end

end
