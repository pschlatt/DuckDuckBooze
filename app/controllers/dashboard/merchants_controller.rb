class Dashboard::MerchantsController < ApplicationController

  def index

    @orders = Order.joins(:order_items).joins(:items).where(items: {user_id: current_user.id}).distinct
  end

  def show

  end
end
