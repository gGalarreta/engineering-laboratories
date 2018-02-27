class Audit < ApplicationRecord

  SUCCESS = "success"
  FAILURE = "failure"

  def self.register user, action, controller, status
    status = status ? SUCCESS : FAILURE
    
    Audit.create(author: user.full_name, author_category: user.category, action: action, action_reference: controller, status: status)
  end
end
