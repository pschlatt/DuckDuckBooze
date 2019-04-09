require "rails_helper"

describe 'profile orders page' do
  it 'links to order show page showing order info' do
    user = create(:user)
    item_1 = create(:item)
    item_2 = create(:item)
    item_3 = create(:item)
    order_1 = Order.create!(user_id: user.id, status: 1)
    order_2 = Order.create!(user_id: user.id)
    oi_1 = OrderItem.create!(order_id: order_1.id, item_id: item_1.id, quantity: 5, order_price: 3.5)
    oi_2 = OrderItem.create!(order_id: order_1.id, item_id: item_2.id, quantity: 10, order_price: 4.5)
    oi_3 = OrderItem.create!(order_id: order_1.id, item_id: item_3.id, quantity: 15, order_price: 5.5)
    oi_4 = OrderItem.create!(order_id: order_2.id, item_id: item_1.id, quantity: 5, order_price: 3.5)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit profile_orders_path
    click_link "#{order_1.id}"

    expect(current_path).to eq(profile_order_path(order_1))
    expect(page).to have_content("Order ID: #{order_1.id}")
    expect(page).to have_content("Created at: #{order_1.created_at.to_s(:long)}")
    expect(page).to have_content("Last updated: #{order_1.updated_at.to_s(:long)}")
    expect(page).to have_content("Order status: #{order_1.status}")
    expect(page).to have_content("Grand total: $145.00")
    expect(page).to have_content("Order quantity: #{order_1.order_quantity(order_1)}")
    within ".item#{oi_1.id}" do
      expect(page).to have_content(order_1.order_items.first.item.name)
      expect(page).to have_content(order_1.order_items.first.item.description)
      expect(page).to have_content("Quantity: #{order_1.order_items.first.quantity}")
      expect(page).to have_content("Price: #{order_1.order_items.first.order_price}")
      expect(page).to have_content("Subtotal: $17.50")
      expect(page).to have_content(order_1.order_items.first.item.image)
    end
    within ".item#{oi_2.id}" do
      expect(page).to have_content(item_2.name)
      expect(page).to have_content(item_2.description)
      expect(page).to have_content("Quantity: #{oi_2.quantity}")
      expect(page).to have_content("Price: #{oi_2.order_price}")
      expect(page).to have_content("Subtotal: $45.00")
      expect(page).to have_content(item_2.image)
    end
    within ".item#{oi_3.id}" do
      expect(page).to have_content(item_3.name)
      expect(page).to have_content(item_3.description)
      expect(page).to have_content("Quantity: #{oi_3.quantity}")
      expect(page).to have_content("Price: #{oi_3.order_price}")
      expect(page).to have_content("Subtotal: $82.50")
      expect(page).to have_content(item_3.image)
    end
  end
end
