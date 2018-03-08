class Service < ApplicationRecord

  MONTHS = ["january","february","march","april","may","june","july","august","september","october","november","december"]

  has_many :preliminary_orders
  has_many :costing_comments
  has_many :custody_orders
  belongs_to :laboratory, required: false
  belongs_to :client, required: false, class_name: "User"
  belongs_to :employee, required: false, class_name: "User"
  
  scope :belongs_to_client, -> (current_user) {where(client_id: current_user)}
  scope :advanced_search, -> (start_date, end_date) {where('pick_up_date BETWEEN ? AND ?', start_date, end_date)}
  scope :unfunded_services, -> (current_user) {belongs_work_environment(current_user).created}
  scope :worked_services, -> (current_user) {belongs_work_environment(current_user).worked}
  scope :contract_bound_services, -> (current_user) {belongs_work_environment(current_user).with_contract}
  scope :funded_services, -> (current_user) {belongs_work_environment(current_user).initial_costed.where(funded_validation: true)}
  scope :adjusted_services, -> (current_user) {belongs_work_environment(current_user).adjusted}
  scope :unclassified_services, -> (current_user) {belongs_work_environment(current_user).accepted}

  accepts_nested_attributes_for :preliminary_orders, allow_destroy: true
  accepts_nested_attributes_for :costing_comments, allow_destroy: true

  enum progress: [:created, :initial_costed, :accepted, :unclassified, :classified, :with_assigned_worker, :worked, :adjusted, :with_contract, :completed]

  
  def attended_message
    message = self.attended ? "ATENDIDO" : "PENDIENTE"
  end

  def self.initialize params, current_user
    service = Service.new params
    service.client = current_user
    service.progress = "created"
    service
  end

  def self.pending_services current_user
    services = belongs_work_environment(current_user).initial_costed.where(funded_validation: false)
    if current_user.employee?
      services = services.where(attended: false)
    end
    services
  end

  def self.belongs_work_environment current_user
    if current_user.admin?
      Service.all
    elsif current_user.employee?
      where(laboratory_id: current_user.laboratory)
    elsif current_user.client?
      belongs_to_client(current_user)
    end
  end

  def self.get_chart_values_through_months start_month, end_month
    values = []
    current_year =  Time.new.year
    for index in MONTHS.index(start_month.downcase)...(MONTHS.index(end_month.downcase)+1)
      current_month = Time.new(current_year, index+1, 1)
      elements = where("created_at > ? AND created_at < ?", current_month.beginning_of_month, current_month.end_of_month)
      values.push(elements.size)
    end
    values
  end  

  def progress_percentage
    current_progress = progress_before_type_cast + 1
    ((current_progress.to_f / Service.progresses.size)*100).to_i
  end

  def can_see_this_information necessary_progress_state
    current_progress = progress_before_type_cast
    limit_progresss = Service.progresses[necessary_progress_state]
    current_progress >= limit_progresss
  end

  def set_next_step current_user
    current_progress = progress_before_type_cast
    if self.funded_validation
      self.progress = current_progress + 1
    else
      self.attended = current_user.employee?
    end
  end

  def update_and_set_next_step params, current_user
    assign_attributes params
    set_next_step current_user
  end


  def create_custory_orders_from_preliminary_order params, current_user
    self.preliminary_orders.each.with_index(1) do |preliminary_order, index|
      custody_order = CustodyOrder.initialize current_user, params, preliminary_order, self
      custody_order.create_processed_sample preliminary_order
    end
  end

  def assign_worker_to_job params, current_user
    create_custory_orders_from_preliminary_order params, current_user
    p "**********************"
    ap self
    set_next_step current_user
    p "**********************"
    ap self
  end

end
