class OrderItem < ApplicationRecord
  validates_presence_of :fulfilled
  validates_presence_of :quantity
  validates_presence_of :order_price

  validates_numericality_of :quantity
  validates_numericality_of :order_price
  validates_inclusion_of :fulfilled, in: [true, false]

  belongs_to :item
  belongs_to :order
end
