class MerchantsController < ApplicationController

  def index
    if current_admin?
      @merchants = User.where(role: 'merchant')
    else
      @merchants = User.where(role: 'merchant', enabled: true)
    end
    @merchants_top_rev = User.top_three_rev
    @merchants_fastest = User.top_three_fast
    @merchants_slowest = User.bot_three_fast
    @big_orders = Order.largest_3_orders
    @top_cities = User.top_three_cities
  end

end
