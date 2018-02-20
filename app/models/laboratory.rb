class Laboratory < ApplicationRecord

  include ApplicationHelper

  has_many :roles
  has_many :sample_methods

  validates_presence_of :name
  
  scope :only_actives, -> {where(active: true)}


  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, length: { maximum: 255}, 
                    format: { with: VALID_EMAIL_REGEX},
                    uniqueness: true



end
