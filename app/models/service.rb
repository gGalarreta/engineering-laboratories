class Service < ApplicationRecord


  has_many :preliminary_orders
  belongs_to :laboratory, required: false
  belongs_to :client, required: false, class_name: "User"
  
  scope :belongs_to_client, -> (current_user) {where(client_id: current_user)}

  accepts_nested_attributes_for :preliminary_orders, allow_destroy: true

  enum progress: [:created, :with_contract, :completed]

  
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

end
