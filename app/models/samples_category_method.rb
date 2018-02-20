class SamplesCategoryMethod < ApplicationRecord

  belongs_to :sample_category
  belongs_to :sample_method

  has_many :features

  accepts_nested_attributes_for :features, :allow_destroy => true, :reject_if => :all_blank
  
  
end
