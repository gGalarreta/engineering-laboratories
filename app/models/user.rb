class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  include ApplicationHelper

  PASSWORD = "pucppass2018"
  MONTHS = ["january","february","march","april","may","june","july","august","september","october","november","december"]

  belongs_to :role, required: false
  belongs_to :laboratory, required: false
  has_many :client_services, class_name: "Service", foreign_key: 'client_id'
  has_many :employee_services, class_name: "Service", foreign_key: 'employee_id'
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :verify_role
  before_save :verify_laboratory

  scope :only_clients_actives, -> {client.where(active: true)}
  scope :only_employees_actives, -> {employee.where(active: true)}
  scope :valid_workers_to_assign_job, ->(current_user) {belongs_work_environment(current_user).where.not(id: current_user.id)}
  
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
  
  def assign_attr user_params, params
    password = params[:password] if params[:password].present?
    assign_attributes user_params
  end
  
  def self.get_chart_values_through_months start_month, end_month
    values = []
    current_year =  Time.new.year
    for index in MONTHS.index(start_month.downcase)...(MONTHS.index(end_month.downcase)+1)
      current_month = Time.new(current_year, index+1, 1)
      elements = where("created_at > ? AND created_at < ?", current_month.beginning_of_month, current_month.end_of_month)
      values.push(elements.size)
    end
    values
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

