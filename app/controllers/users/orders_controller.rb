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

  private

  def check_user_status
    render file: "/public/404", status: 404 unless registered_user?
  end
end
