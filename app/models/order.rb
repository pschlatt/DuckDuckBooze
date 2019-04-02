class Order < ApplicationRecord
  validates_presence_of :status

  # validates_numericality_of :status
  # validates_inclusion_of :status, :in => 0..3
  # validates_inclusion_of :status, in: ['pending', 'packaged', 'shipped', 'cancelled']

  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  enum status: ['pending', 'packaged', 'shipped', 'cancelled']
end
