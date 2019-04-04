class CartsController < ApplicationController

  def show
  end

  def create
    item = Item.find(params[:item_id])
    item_id_to_s = item.id.to_s
    session[:cart] ||= Hash.new(0)
    session[:cart][item_id_to_s] ||= 0
    session[:cart][item_id_to_s] += 1
    flash[:notice] = "You have added #{item.name} to your cart"
    redirect_to items_path
  end
end
