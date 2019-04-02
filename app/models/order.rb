class Order < ApplicationRecord
  validates_presence_of :status

  validates_numericality_of :status
  validates_inclusion_of :status, :in => 0..3

  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items
end
