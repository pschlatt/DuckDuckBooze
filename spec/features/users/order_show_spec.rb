require "rails_helper"
# As a registered user
# When I visit my Profile Orders page, "/profile/orders"
# I see every order I've made, which includes the following information:
# - the ID of the order, which is a link to the order show page
# - the date the order was made
# - the date the order was last updated
# - the current status of the order
# - the total quantity of items in the order
# - the grand total of all items for that order
describe 'the user profile orders page' do
  it 'shows order information' do
    user = create(:user)
    merchant = create(:merchant)
    beer_1 = Item.create!(name: "MGD", description: "good beer", stock: 12, item_price: 1.5, user_id: merchant.id )
    beer_2 = Item.create!(name: "Mich Ultra", description: "better beer", stock: 15, item_price: 2.5, user_id: merchant.id )
    beer_3 = Item.create!(name: "4 Noses", description: "yummy beer", stock: 18, item_price: 3.5, user_id: merchant.id )
    order_1 = user.orders.create!(created_at: 3.days.ago)
    order_2 = user.orders.create!(created_at: 2.days.ago)
    oi_1 = OrderItem.create!(fulfilled: false, quantity: 3, order_price: 3, order_id: order_1.id, item_id: beer_1.id, updated_at: 1.day.ago)
    oi_2 = OrderItem.create!(fulfilled: false, quantity: 6, order_price: 2, order_id: order_2.id, item_id: beer_2.id, updated_at: 1.day.ago)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit profile_orders_path

    within ".info-#{order_1.id}" do
      expect(page).to have_link("#{order_1.id}")
      expect(page).to have_content("#{order_1.created_at}")
      expect(page).to have_content("#{oi_1.updated_at}")
      expect(page).to have_content("#{oi_1.status}")
      expect(page).to have_content("#{oi_1.quan}")
      expect(page).to have_content("#{oi_1.status}")
    end
  end
end
