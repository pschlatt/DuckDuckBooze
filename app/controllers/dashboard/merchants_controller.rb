class Dashboard::MerchantsController < ApplicationController
  before_action :check_merchant_status

  def index
  end

  def show
    @merchant = current_user
    @orders = Order.joins(:order_items).joins(:items).where(items: {user_id: current_user.id}).distinct
  end

  private

  def check_merchant_status
    render file: "/public/404", status: 404 unless current_merchant?
  end

  private

  def check_merchant_status
    render file: "/public/404", status: 404 unless current_merchant?
  end
  
end
