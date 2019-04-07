class Users::OrdersController < ApplicationController

  def index
    # binding.pry
    if registered_user?
      @orders = current_user.orders
    end
  end


  def show
  end

end
