class User < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :street
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip
  validates_presence_of :email
  validates_presence_of :role
  validates_presence_of :enabled
  validates :password, uniqueness: true
  validates_inclusion_of :role, in: 0..3

  has_many :items
  has_many :orders
end
