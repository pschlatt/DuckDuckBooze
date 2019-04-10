class Users::OrdersController < ApplicationController
  before_action :check_user_status

  def index
    if registered_user?
      @orders = current_user.orders
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    order.update(status: 'cancelled')
    order.change_oi_status(order)
    order.restock_items(order)
    flash[:notice] = "#{order.id} has been cancelled"
    redirect_to profile_path
  end

  private

  def check_user_status
    render file: "/public/404", status: 404 unless registered_user?
  end
end
