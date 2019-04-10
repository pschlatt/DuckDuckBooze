class ItemsController < ApplicationController

  def index
    @items = enabled_items
    @top_five_stats = Item.five_stats(:desc)
    @bottom_five_stats = Item.five_stats(:asc)
  end

  def show
    @item = Item.find(params[:id])
  end


private

  def enabled_items
    Item.where(enabled: true)
  end
end
