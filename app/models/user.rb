class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  PASSWORD = "pucppass2018"

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :verify_role
  before_save :verify_laboratory

  belongs_to :role, required: false
  belongs_to :laboratory, required: false
  
  enum category: [:admin, :employee, :client]
  enum gender: [:male, :female]
  
  def full_name
    first_name + " " +last_name
  end

  def self.belongs_work_environment current_user
    if current_user.admin?
      User.employee 
    elsif current_user.employee?
      where(laboratory_id: current_user.laboratory)
    end
  end

  def self.initialize params, current_user
    user = User.new params
    user.laboratory = current_user.laboratory if current_user.employee?
    user.password = PASSWORD
    user
  end
  
  private

    def verify_role
      self.role = Role.find_by(name: "administrador") if admin?
      self.role = Role.find_by(name: "cliente") if client?
      if employee? and !self.role.present?
        self.errors.add(:role, message: "El empleado debe tener un rol")
        raise ActiveRecord::Rollback
      end
    end

    def verify_laboratory
      if employee? and !self.laboratory.present?
        self.errors.add(:role, message: "El empleado debe tener un rol")
        raise ActiveRecord::Rollback        
      end
    end
end

