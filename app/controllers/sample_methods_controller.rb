class SampleMethodsController < ApplicationController

  before_action :laboratories, only: [:new, :create, :edit, :update]
  before_action :set_sample_method, only: [:show, :edit, :update, :toggle_status]

  def index
    @sample_methods = SampleMethod.all
  end

  def new
    @sample_method = SampleMethod.new
  end

  def create
    @sample_method = SampleMethod.initialize sample_method_params, current_user
    if @sample_method.save
      redirect_to sample_methods_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @sample_method.update_attributes sample_method_params
      redirect_to sample_methods_path
    else
      render :edit
    end
  end

  def show
  end

  def toggle_status
    @sample_method.change_status
    respond_to do |format|
      format.js
    end
  end     

  private
    def sample_method_params
      params.require(:sample_method).permit(:id, :name, :description, :unit_cost, :accreditation, :laboratory_id)
    end

    def laboratories
      @laboratories = Laboratory.all
    end

    def set_sample_method
      @sample_method = SampleMethod.find params[:id]
    end

end
