class SampleCategoriesController < ApplicationController

  before_action :set_sample_category, only: [:edit, :update, :show, :toggle_status]

  before_action :laboratories, only: [:new, :create, :edit, :update]

  before_action :sample_methods, only: [:new, :create, :edit, :update]

  def index
    @sample_categories = SampleCategory.belongs_work_environment current_user
  end

  def new
    @sample_category = SampleCategory.new
  end

  def create
    @sample_category = SampleCategory.initialize sample_category_params, current_user
    if @sample_category.valid
      redirect_to sample_categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @sample_category.assign_attributes sample_category_params
    if @sample_category.valid
      redirect_to sample_categories_path
    else
      render :edit
    end
  end

  def show
  end

  def toggle_status
    @sample_category.change_status
    respond_to do |format|
      format.js
    end
  end

  private

    def sample_category_params
      params.require(:sample_category).permit(:id, :laboratory_id, :name, :description, samples_category_methods_attributes: sample_category_methods_params)  
    end

    def sample_category_methods_params
       [:id, :_destroy, :sample_category_id, :sample_method_id, features_attributes: feature_params]
     end 

    def feature_params
      [:id, :description, :minimun_value, :maximum_value, :_destroy]
    end

    def set_sample_category
      @sample_category = SampleCategory.find params[:id]
    end

    def sample_methods
      @sample_methods = SampleMethod.only_actives
    end

    def laboratories
      @laboratories = Laboratory.only_actives
    end

end
