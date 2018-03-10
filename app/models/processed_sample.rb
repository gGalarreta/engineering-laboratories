class ProcessedSample < ApplicationRecord
  
  belongs_to :preliminary_order
  belongs_to :service
  belongs_to :custody_order

  def self.initialize preliminary_order, custody_order
    processed_sample = ProcessedSample.new
    processed_sample.preliminary_order = preliminary_order
    processed_sample.custody_order = custody_order
    processed_sample.service = custody_order.service
    processed_sample.save
  end

  def update_order params, custody_order
    if (custody_order.revision_number > 0)
      custody_order.reset_validation
    end
    self.classified_values = params["classified_values"]
    save
  end
end
