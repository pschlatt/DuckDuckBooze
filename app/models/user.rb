class User < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :street
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip
  validates_presence_of :email
  validates_presence_of :password
  validates_presence_of :role
  validates_inclusion_of :enabled, in: [true, false]


  validates :email, uniqueness: true
  # validates_numericality_of :role
  # validates_inclusion_of :role, :in => 0..3

  has_many :items
  has_many :orders
  has_secure_password 

  enum role: ['visitor', 'registered_user', 'merchant', 'admin']
end
