class Role < ApplicationRecord

  has_many :menu_actions, dependent: :destroy
  has_many :menus, through: :menu_actions
  accepts_nested_attributes_for :menu_actions, reject_if: :all_blank, allow_destroy: true


  def menu_uniqueness
    menus = self.menu_actions.to_a.map(&:menu_id)
    menus.length == menus.uniq.length
  end

  def valid
    unless menu_uniqueness
      self.errors.add(:menus, message: "no se puede guardar un mismo")
      false
    else
      self.save
    end
  end 

end
