class ItemsController < ApplicationController

  def index
    @items = enabled_items
    @top_five_stats = Item.five_stats(:desc)
    @bottom_five_stats = Item.five_stats(:asc)
  end

  def show
    @item = Item.find(params[:id])
  end

  def create
    merchant = current_user
    new_item = merchant.items.create(item_params)
    flash[:notice] = "#{new_item.name} has been added!"
    redirect_to dashboard_items_path
  end

private

  def enabled_items
    Item.where(enabled: true)
  end

  def item_params
    params.require(:item).permit(:name, :description, :image, :item_price, :stock)
  end
end
