class Inventory < ApplicationRecord
  include ApplicationHelper

  validates :code, presence: true
  validates :description, presence: true

  belongs_to :laboratory, required: true

  enum status: [:active, :inactive]

  def self.belongs_work_environment current_user
    if current_user.admin?
      Inventory.all
    elsif current_user.employee?
      where(laboratory_id: current_user.laboratory)
    end
  end

end
