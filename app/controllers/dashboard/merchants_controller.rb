class Dashboard::MerchantsController < ApplicationController

  def index
    # binding.pry
    @orders = Order.joins(:order_items).joins(:items).where(items: {user_id: current_user.id})
  end

  def show

  end
end
