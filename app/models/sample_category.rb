class SampleCategory < ApplicationRecord

  include ApplicationHelper

  has_many :samples_category_methods
  has_many :sample_methods, through: :samples_category_methods

  accepts_nested_attributes_for :sample_methods, :allow_destroy => true, :reject_if => :all_blank

  accepts_nested_attributes_for :samples_category_methods, :allow_destroy => true, :reject_if => :all_blank

  #accepts_nested_attributes_for :features, :allow_destroy => true, :reject_if => :all_blank

  def self.belongs_work_environment current_user
    if current_user.admin?
      SampleCategory.all
    elsif current_user.employee?
      where(laboratory_id: current_user.laboratory)
    end
  end  
end
