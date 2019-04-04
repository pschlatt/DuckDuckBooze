class ItemsController < ApplicationController

  def index
    @items = enabled_items
    # binding.pry
    @top_five_stats = Item.top_five_stats
  end

  def show

  end

end

private

  def enabled_items
    Item.where(enabled: true)
  end
