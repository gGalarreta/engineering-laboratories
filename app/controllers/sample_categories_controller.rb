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
  end

  def edit
  end

  def update
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
