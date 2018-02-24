class SystemParameter < ApplicationRecord

  include ApplicationHelper

  belongs_to :laboratory

  enum feature: [:name_app, :welcome_message, :terms_and_condition]

  def can_show_description
    ["name_app", "welcome_message", "terms_and_condition"].include?(self.feature)
  end

  def self.belongs_work_environment current_user
    if current_user.admin?
      SystemParameter.all
    elsif current_user.employee?
      where(laboratory_id: current_user.laboratory)
    end
  end
end
