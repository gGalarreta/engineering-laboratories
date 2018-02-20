class SampleCategory < ApplicationRecord

  include ApplicationHelper

  def self.belongs_work_environment current_user
    if current_user.admin?
      SampleCategory.all
    elsif current_user.employee?
      where(laboratory_id: current_user.laboratory)
    end
  end  
end
