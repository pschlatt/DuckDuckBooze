class ItemsController < ApplicationController

  def index
    @items = enabled_items
  end

  def show
    
  end

end

private

  def enabled_items
    Item.where(enabled: true)
  end
