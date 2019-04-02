class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :stock
  validates_presence_of :item_price
  validates_presence_of :enabled
  # validates_presence_of :image

  validates_numericality_of :stock
  validates_numericality_of :item_price

  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items

end
