class ProcessedSample < ApplicationRecord
  
  belongs_to :preliminary_order
  belongs_to :custody_order

  def self.initialize preliminary_order, custody_order
    processed_sample = ProcessedSample.new
    processed_sample.preliminary_order = preliminary_order
    processed_sample.custody_order = custody_order
    processed_sample.save
  end

  def update_order params, preliminary_order, custody_order
    if (custody_order.revision_number < 1)
      self.description = params[:description]
      self.pucp_code = params[:pucp_code]
      self.client_code = preliminary_order.name
      self.classified_values = params["sp_value"]
    else
      self.pucp_code = params[:processed_sample][:pucp_code]
      self.classified_values = params["sp_value"]
      custody_order.reset_validation
    end
    save
  end
end
