class Role < ApplicationRecord

  has_many :menu_actions, dependent: :destroy
  has_many :menus, through: :menu_actions
  accepts_nested_attributes_for :menu_actions, reject_if: :all_blank, allow_destroy: true

  belongs_to :laboratory, required: false
  

  validates_presence_of :name

  before_save :verify_laboratory

  def menu_uniqueness
    menus = self.menu_actions.to_a.map(&:menu_id)
    menus.length == menus.uniq.length
  end

  def valid
    unless menu_uniqueness
      self.errors.add(:menus, message: "no se puede guardar un mismo")
      raise ActiveRecord::Rollback
    else
      self.save
    end
  end 

  def self.belongs_work_environment current_user
    if current_user.admin?
      Role.all
    elsif current_user.employee?
      where(laboratory_id: current_user.laboratory)
    end
      
  end

  private

    def verify_laboratory
      #dependiendo el current user
      #se debe setear el laboratorio por default
      #ocultar en el form el laboraotrio
      #cuando sea admin
    end

end
