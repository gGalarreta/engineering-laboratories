class CustodyOrder < ApplicationRecord
  
  belongs_to :employee , required: false, class_name: "User"
  belongs_to :supervisor , required: false, class_name: "User"
  belongs_to :service , required: false

  has_one :processed_sample

  scope :belongs_to_service, -> (service) {where(service_id: service.id)}
  scope :custody_orders_to_check, -> (current_user) {where(supervisor_id: current_user).to_check}
  scope :custody_orders_to_classified, -> (current_user) {(where(employee_id: current_user).to_classified).where(revision_number: 0)}
  scope :custody_orders_to_reclassify, -> (current_user) {(where(employee_id: current_user).to_classified).where(supervised_validation: false)}

  enum custody_progress: [:to_classified, :to_check, :completed]

  def self.initialize current_user, params, preliminary_order, service
    custody_order = CustodyOrder.new
    custody_order.supervisor = current_user
    custody_order.custody_progress = "to_classified"
    custody_order.service = service
    custody_order.subject = service.subject + " " + preliminary_order.sample_category.name
    custody_order.employee_id = params["selected_employee_" + preliminary_order.id.to_s]
    custody_order.revision_number = 0
    custody_order.save
    custody_order
  end


  def set_next_step current_user
    current_progress = custody_progress_before_type_cast
    current_revision_number = revision_number_before_type_cast
    if self.supervised_validation
      self.custody_progress = current_progress + 1
    elsif (self.supervisor == current_user)
      self.custody_progress = current_progress -1
      self.revision_number = current_revision_number + 1
    end
  end

  def update_order current_user
    set_next_step current_user
    save
  end

  def create_processed_sample preliminary_order
    ProcessedSample.initialize preliminary_order, self
  end

  def reset_validation
    self.supervised_validation = true
    self.save
  end

end
