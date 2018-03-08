class PreliminaryOrder < ApplicationRecord

  belongs_to :service, required: false
  belongs_to :sample_method, required: false
  belongs_to :sample_category, required: false  
  has_one :processed_sample

  def number_of_samples
    quantity
  end

  def number_of_features
    sample_category.samples_category_methods.where(sample_method_id: self.sample_method_id).first.features.pluck(:description)
  end  
end
