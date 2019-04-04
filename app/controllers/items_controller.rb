class ItemsController < ApplicationController

  def index
    @items = enabled_items
    @cart = Cart.new(session[:cart])
  end

  def show
    @item = Item.find(params[:id])
  end

private

  def enabled_items
    Item.where(enabled: true)
  end
end
