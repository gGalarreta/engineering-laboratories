class CustodyOrder < ApplicationRecord
  belongs_to :employee , required: false, class_name: "User"
  belongs_to :supervisor , required: false, class_name: "User"
  belongs_to :service , required: false

  has_one :processed_sample

  scope :custody_orders_per_service, -> (service) {where(service_id: service.id)}
  scope :custody_orders_to_check, -> (current_user) {(where(supervisor_id: current_user).to_check)}
  scope :custody_orders_to_classified, -> (current_user) {(where(employee_id: current_user).to_classified)}
  scope :custody_orders_to_reclassify, -> (current_user) {where(employee_id: current_user).to_reclassify}

  enum custody_progress: [:to_classified,:to_check,:to_reclassify,:completed]

  def self.initialize current_user
    custody_order = CustodyOrder.new
    custody_order.supervisor = current_user
    custody_order.custody_progress = "to_classified"
    custody_order
  end

  def handling_internal_process current_user
      incredRevision = false
      if self.to_reclassify?
        increseRevision = true
      end
      self.to_check! if self.to_reclassify?
      if self.to_check? and self.supervised_validation
        self.completed!
      end
      self.to_reclassify! if ((self.to_check? and !increseRevision) and !self.supervised_validation)
      self.to_check! if self.to_classified?
   end

   def assign_attr params, preliminary_order,index, service
    processed_sample = ProcessedSample.initialize preliminary_order, self
    processed_sample.save
    custody_order_params = {service_id: service.id}
    custody_order_params[:subject] = service.subject + " " + preliminary_order.sample_category.name
    custody_order_params[:employee_id] = params["selected_employee_" + preliminary_order.id.to_s]
    self.assign_attributes custody_order_params
   end

   def assign_validation params
    p params[:supervised_validation]
     self.supervised_validation = params["custody_order"][:supervised_validation]
   end

end
