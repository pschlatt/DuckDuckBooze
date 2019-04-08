class Order < ApplicationRecord
  validates_presence_of :status

  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  enum status: ['pending', 'packaged', 'shipped', 'cancelled']

  def order_quantity(order_id)
    OrderItem.where(order_id: order_id)
         .sum(:quantity)
  end

  def order_grand_total(order_id)
    OrderItem.where(order_id: order_id)
         .sum("quantity * order_price")
  end
end
