class User < ApplicationRecord

  enum category: [:admin, :employee, :client]
  enum gender: [:male, :female]
  
  def full_name
    first_name + " " +last_name
  end
end
