class MenuAction < ApplicationRecord

  belongs_to :menu
  belongs_to :role
  
  validates_uniqueness_of :menu_id, :scope => :role_id
end
