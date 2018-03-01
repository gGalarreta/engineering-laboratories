class Service < ApplicationRecord


  has_many :preliminary_orders
  belongs_to :laboratory, required: false
  belongs_to :client, required: false, class_name: "User"
  belongs_to :employee, required: false, class_name: "User"
  
  scope :belongs_to_client, -> (current_user) {where(client_id: current_user)}
  scope :advanced_search, -> (start_date, end_date) {where('pick_up_date BETWEEN ? AND ?', start_date, end_date)}
  scope :unfunded_services, -> (current_user) {belongs_work_environment(current_user).created}
  scope :worked_services, -> (current_user) {belongs_work_environment(current_user).worked}
  scope :contract_bound_services, -> (current_user) {belongs_work_environment(current_user).with_contract}


  accepts_nested_attributes_for :preliminary_orders, allow_destroy: true

  enum progress: [:created, :initial_accepted, :with_assigned_worker, :worked, :adjusted, :with_contract, :completed]

  
  def self.initialize params, current_user
    service = Service.new params
    service.client = current_user
    service.progress = "created"
    service
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

  def self.belongs_work_environment current_user
    if current_user.admin?
      Service.all
    elsif current_user.employee?
      where(laboratory_id: current_user.laboratory)
    elsif current_user.client?
      belongs_to_client(current_user)
    end
  end

end
