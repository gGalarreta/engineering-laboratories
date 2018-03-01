class Service < ApplicationRecord


  has_many :preliminary_orders
  has_many :costing_comments
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

  accepts_nested_attributes_for :preliminary_orders, allow_destroy: true
  accepts_nested_attributes_for :costing_comments, allow_destroy: true

  enum progress: [:created, :initial_costed, :accepted, :with_assigned_worker, :worked, :adjusted, :with_contract, :completed]

  
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
    #con el tiempo habra que agregar mas validaciones 
    #cuando quiera avanzar de nivelo quedarse en el mismo
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


end
