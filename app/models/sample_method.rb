class SampleMethod < ApplicationRecord
  include ApplicationHelper

  belongs_to :laboratory

  has_many :samples_category_methods
  has_many :sample_categories, through: :samples_category_methods

  
  validates :name, presence: true
  validates :unit_cost, numericality: { :greater_than_or_equal_to => 0 }
  
  scope :only_actives, -> {where(active: true)}
  
  enum accreditation: [:accredited, :non_accredited]
  
  def self.initialize params, current_user
    sample_method = SampleMethod.new params
    sample_method.laboratory = current_user.laboratory if current_user.employee?
    sample_method
  end
end
