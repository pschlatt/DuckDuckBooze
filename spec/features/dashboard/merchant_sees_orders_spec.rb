require "rails_helper"
# As a merchant
# When I visit my dashboard ("/dashboard")
# If any users have pending orders containing items I sell
# Then I see a list of these orders.
# Each order listed includes the following information:
# - the ID of the order, which is a link to the order
# show page ("/dashboard/orders/15")
# - the date the order was made
# - the total quantity of my items in the order
# - the total value of my items for that order
describe 'when merchant visits their dashboard' do
  before :each do
    @merch = create(:merchant)
    @other_merch = create(:merchant)
    @item_1 = create(:item, user_id: @merch.id, stock: 75)
    @item_2 = create(:item, user_id: @merch.id, stock: 85)
    @item_3 = create(:item, user_id: @merch.id, stock: 95)
    @item_4 = create(:item, user_id: @other_merch.id)
    @user_1 = create(:user)
    @user_2 = create(:user)
    @order_1 = create(:order, user_id: @user_1.id, created_at: 1.day.ago)
    @order_2 = create(:order, user_id: @user_1.id)
    @order_3 = create(:order, user_id: @user_2.id)
    @order_3 = create(:order, status: 'shipped', user_id: @user_2.id)
    @order_4 = create(:shipped_order, user_id: @user_2.id)
    @order_item_1 = OrderItem.create(quantity: 6, order_price: 2.0, order_id: @order_1.id, item_id: @item_1.id)
    @order_item_2 = OrderItem.create(quantity: 4, order_price: 3.0, order_id: @order_1.id, item_id: @item_2.id)
    @order_item_3 = OrderItem.create(quantity: 3, order_price: 4.0, order_id: @order_2.id, item_id: @item_3.id)
    @order_item_4 = OrderItem.create(quantity: 5, order_price: 2.0, order_id: @order_3.id, item_id: @item_3.id)
    @order_item_5 = OrderItem.create(quantity: 7, order_price: 3.0, order_id: @order_3.id, item_id: @item_4.id)
  end

    it 'shows pending orders' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merch)

    visit dashboard_path

    expect(page).to have_link("Order: #{@order_1.id}")
    expect(page).to have_content("Order placed on: #{@order_1.created_at.to_s(:long)}")
    expect(page).to have_content("Quantity of items in the order: 10")
    expect(page).to have_content("Total value of items for the order: $24.00")
  end
end
