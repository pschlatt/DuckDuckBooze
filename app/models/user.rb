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

  has_many :items
  has_many :orders
  has_secure_password

  enum role: ['visitor', 'registered_user', 'merchant', 'admin']

  def avg_fill_time(item)
    order_items = OrderItem
      .joins(item: :user)
      .where("users.id = ? and items.id = ?", id, item.id)
      .where(fulfilled: true)

    if order_items.present?
      fulfillment_times = order_items.map do |order_item|
        (order_item.updated_at - order_item.created_at).to_i / 1.hours
      end
      fulfillment_times.sum / fulfillment_times.count
    end
  end
end
