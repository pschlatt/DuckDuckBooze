require 'rails_helper'

RSpec.describe 'Merchant Items Index Page', type: :feature do
  context 'as a merchant visiting my items page - when I click an enable button next to an item' do
    before :each do

      @merch = create(:merchant)
      #
      # @item_1 = create(:item, user_id: @merch.id, stock: 75)
      # @item_2 = create(:item, user_id: @merch.id, stock: 85)
      # @item_3 = create(:item, user_id: @merch.id, stock: 95)

      # @order_2 = create(:order, user_id: @user_1.id)
      # @order_3 = create(:order, user_id: @user_2.id)
      # @order_3 = create(:order, status: 'shipped', user_id: @user_2.id)
      # @order_4 = create(:shipped_order, user_id: @user_2.id)
      # @order_item_1 = OrderItem.create(quantity: 6, order_price: 2.0, order_id: @order_1.id, item_id: @item_1.id)
      # @order_item_2 = OrderItem.create(quantity: 4, order_price: 3.0, order_id: @order_1.id, item_id: @item_2.id)
      # @order_item_3 = OrderItem.create(quantity: 3, order_price: 4.0, order_id: @order_2.id, item_id: @item_3.id)
      # @order_item_4 = OrderItem.create(quantity: 5, order_price: 2.0, order_id: @order_3.id, item_id: @item_3.id)
      # @order_item_5 = OrderItem.create(quantity: 7, order_price: 3.0, order_id: @order_3.id, item_id: @item_4.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merch)

      visit dashboard_items_path

    end

    it 'return me to my items page, I see a confirmation message, and I see that the item is now enabled for sale' do


    end
  end
end

#
# As a merchant
# When I visit my items page
# And I click on an "enable" button or link for an item
# I am returned to my items page
# I see a flash message indicating this item is now available for sale
# I see the item is now enabled
