class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :stock
  validates_presence_of :item_price
  validates_inclusion_of :enabled, in: [true, false]
  validates_presence_of :image

  validates_numericality_of :stock
  validates_numericality_of :item_price

  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items

  def self.five_stats(updown)
    list = OrderItem.joins(:item)
                    .select("items.*, order_items.quantity")
                    .order(quantity: updown)
    list.limit(5)
  end


  def never_ordered?
    !OrderItem.exists?(item_id: id)
  end

end
