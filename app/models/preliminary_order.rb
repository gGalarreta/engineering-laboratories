class PreliminaryOrder < ApplicationRecord

  belongs_to :service, required: false
  belongs_to :sample_method, required: false
  belongs_to :sample_category, required: false  
  has_one :processed_sample
end
