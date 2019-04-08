 class User < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :street
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip
  validates_presence_of :email
  validates_presence_of :role
  validates_inclusion_of :enabled, in: [true, false]

  validates :email, uniqueness: true

  has_many :items
  has_many :orders
  has_secure_password

  enum role: ['visitor', 'registered_user', 'merchant', 'admin']

  def self.top_three_rev
    User.where(role: 'merchant')
        .joins(items: :order_items)
        .select("users.*,sum(order_items.quantity * order_items.order_price) as total_revenue")
        .group(:id)
        .order("total_revenue desc")
        .limit(3)
  end

  def self.top_three_fast
    # binding.pry
    User.joins(items: :order_items)
        .select("users.*, avg(order_items.updated_at - order_items.created_at) AS avg_fill_time, count(DISTINCT order_items.order_id) AS order_count")
        .where(role: :merchant, enabled: true, order_items: {fulfilled: true})
        .group(:id)
        .order("avg_fill_time ASC")
        .limit(3)
  end

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


# sorting
 #User.where(role: 'merchant').joins(items: :order_items).select("users.*,sum(order_items.quantity) as total_quantity").group(:id).order("total_quantity desc")


# User.where(role: 'merchant').joins(items: :order_items).select("users.*,sum(order_items.quantity * order_items.order_price) as total_revenue").group(:id).order("total_revenue desc")
# test=_
# test.first.name
# test.first.total_revenue
