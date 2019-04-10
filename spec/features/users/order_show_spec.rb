require "rails_helper"

describe 'the user profile orders page' do
  it 'shows order information' do
    user = create(:user)
    merchant = create(:merchant)
    beer_1 = Item.create!(name: "MGD", description: "good beer", stock: 12, item_price: 1.5, user_id: merchant.id )
    beer_2 = Item.create!(name: "Mich Ultra", description: "better beer", stock: 15, item_price: 2.5, user_id: merchant.id )
    beer_3 = Item.create!(name: "4 Noses", description: "yummy beer", stock: 18, item_price: 3.5, user_id: merchant.id )
    order_1 = user.orders.create!(created_at: 3.days.ago, updated_at: 1.day.ago)
    order_2 = user.orders.create!(created_at: 2.days.ago, updated_at: 1.day.ago)
    oi_1 = OrderItem.create!(fulfilled: false, quantity: 3, order_price: 3, order_id: order_1.id, item_id: beer_1.id, updated_at: 1.day.ago)
    oi_2 = OrderItem.create!(fulfilled: false, quantity: 6, order_price: 2, order_id: order_2.id, item_id: beer_2.id, updated_at: 1.day.ago)
    oi_3 = OrderItem.create!(fulfilled: false, quantity: 9, order_price: 4, order_id: order_2.id, item_id: beer_3.id, updated_at: 1.day.ago)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit profile_orders_path

    within "#info-#{order_1.id}" do
      expect(page).to have_link("#{order_1.id}")
      expect(page).to have_content("Created at: #{order_1.created_at.to_s(:long)}")
      expect(page).to have_content("Last updated: #{order_1.updated_at.to_s(:long)}")
      expect(page).to have_content("Order status: #{order_1.status}")
      expect(page).to have_content("Order quantity: #{order_1.order_quantity(order_1.id)}")
      expect(page).to have_content("Grand total: #{order_1.order_grand_total(order_1.id)}")
    end
    within "#info-#{order_2.id}" do
      expect(page).to have_link("#{order_2.id}")
      expect(page).to have_content("Created at: #{order_2.created_at.to_s(:long)}")
      expect(page).to have_content("Last updated: #{order_2.updated_at.to_s(:long)}")
      expect(page).to have_content("Order status: #{order_2.status}")
      expect(page).to have_content("Order quantity: #{order_2.order_quantity(order_2.id)}")
      expect(page).to have_content("Grand total: #{order_2.order_grand_total(order_2.id)}")
    end
  end

  it 'lets user cancel a pending order' do
    user = create(:user)
    merchant = create(:merchant)
    beer_1 = Item.create!(name: "MGD", description: "good beer", stock: 12, item_price: 1.5, user_id: merchant.id )
    beer_2 = Item.create!(name: "Mich Ultra", description: "better beer", stock: 15, item_price: 2.5, user_id: merchant.id )
    beer_3 = Item.create!(name: "4 Noses", description: "yummy beer", stock: 18, item_price: 3.5, user_id: merchant.id )
    order_1 = user.orders.create!(created_at: 3.days.ago, updated_at: 1.day.ago)
    order_2 = user.orders.create!(created_at: 2.days.ago, updated_at: 1.day.ago)
    oi_1 = OrderItem.create!(fulfilled: true, quantity: 3, order_price: 3, order_id: order_1.id, item_id: beer_1.id, updated_at: 1.day.ago)
    oi_2 = OrderItem.create!(fulfilled: false, quantity: 6, order_price: 2, order_id: order_1.id, item_id: beer_2.id, updated_at: 1.day.ago)
    oi_3 = OrderItem.create!(fulfilled: false, quantity: 9, order_price: 4, order_id: order_2.id, item_id: beer_3.id, updated_at: 1.day.ago)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit profile_order_path(order_1)

    expect(page).to have_link("Cancel")
    click_link "Cancel"

    order_1.reload
    oi_1.reload
    oi_2.reload
    beer_1.reload
    beer_2.reload

    expect(order_1.status).to eq("cancelled")
    expect(oi_1.fulfilled).to eq(false)
    expect(oi_2.fulfilled).to eq(false)
    expect(beer_1.stock).to eq(15)
    expect(beer_2.stock).to eq(21)
    expect(current_path).to eq(profile_path)
    expect(page).to have_content("#{order_1.id} has been cancelled")
  end
end
