class SampleMethod < ApplicationRecord

  validates :name, presence: true
  
  validates :unit_cost, numericality: { :greater_than_or_equal_to => 0 }
  
  belongs_to :laboratory
  
  enum accreditation: [:accredited, :non_accredited]
  
  def self.initialize params, current_user
    sample_method = SampleMethod.new params
    sample_method.laboratory = current_user.laboratory if current_user.employee?
    sample_method
  end
end
