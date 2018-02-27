class Supply < ApplicationRecord
  include ApplicationHelper
  validates :name, presence: true
  validates :description, presence: true

  belongs_to :laboratory, required: true

  def self.belongs_work_environment current_user
    if current_user.admin?
      Supply.all
    elsif current_user.employee?
      where(laboratory_id: current_user.laboratory)
    end
  end
end
