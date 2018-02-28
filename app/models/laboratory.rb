class Laboratory < ApplicationRecord

  include ApplicationHelper

  has_many :roles, dependent: :destroy
  has_many :sample_methods, dependent: :destroy
  has_many :services, dependent: :destroy

  validates_presence_of :name
  
  scope :only_actives, -> {where(active: true)}


  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, length: { maximum: 255}, 
                    format: { with: VALID_EMAIL_REGEX},
                    uniqueness: true



end
