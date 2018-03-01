class SampleCategory < ApplicationRecord

  include ApplicationHelper

  has_many :samples_category_methods
  has_many :sample_methods, through: :samples_category_methods
  belongs_to :laboratory

  accepts_nested_attributes_for :sample_methods, allow_destroy: true, reject_if: :all_blank

  accepts_nested_attributes_for :samples_category_methods, allow_destroy: true, reject_if: :all_blank

  scope :only_actives, -> {where(active: true)}

  def self.initialize params, current_user
    sample_category = SampleCategory.new params
    sample_category.laboratory = current_user.laboratory if current_user.employee?
    sample_category
  end
  
  def self.belongs_work_environment current_user
    if current_user.admin?
      SampleCategory.all
    elsif current_user.employee?
      where(laboratory_id: current_user.laboratory)
    end
  end
  
  def unique_sample_methods
    sample_methods = self.samples_category_methods.to_a.map(&:sample_method_id)
    sample_methods.length == sample_methods.uniq.length
  end


  def valid
    unless unique_sample_methods
      self.errors.add(:sample_methods, message: "No se puede guardar un mismo metodo de muestra")
      #raise ActiveRecord::Rollback
      false
    else
      self.save
    end
  end
end
