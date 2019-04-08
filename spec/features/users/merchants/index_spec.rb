require 'rails_helper'

RSpec.describe 'merchant index page' do
  context 'as a visitor visiting the merchant index page' do
    it 'shows all active merchants in the system - with their city, state, and date they registered' do

      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:disabled_merchant)

      visit merchants_path

      expect(page).not_to have_content(merchant_3.name)

      within "#merchant-#{merchant_1.id}" do
        expect(page).to have_content("Name: #{merchant_1.name}")
        expect(page).to have_content("Location: #{merchant_1.city}, #{merchant_1.state}")
        expect(page).to have_content("Registered: #{merchant_1.created_at.strftime("%b %d, %Y")}")
      end

      within "#merchant-#{merchant_2.id}" do
        expect(page).to have_content("Name: #{merchant_2.name}")
        expect(page).to have_content("Location: #{merchant_2.city}, #{merchant_2.state}")
        expect(page).to have_content("Registered: #{merchant_2.created_at.strftime("%b %d, %Y")}")
      end
    end
  end

  context 'merchant index page shows statistics' do
    before :each do
      @user = create(:user)

      @merch_1 = create(:merchant)
      @merch_2 = create(:merchant)
      @merch_3 = create(:merchant)
      @merch_4 = create(:merchant)

      @beer_1 = Item.create!(name: "MGD", description: "good beer", stock: 12, item_price: 1.5, user_id: @merch_1.id )
      @beer_2 = Item.create!(name: "Mich Ultra", description: "better beer", stock: 15, item_price: 2.5, user_id: @merch_2.id )
      @beer_3 = Item.create!(name: "4 Noses", description: "yummy beer", stock: 18, item_price: 3.5, user_id: @merch_3.id )
      @beer_4 = Item.create!(name: "Guiness", description: "the best", stock: 18, item_price: 3.5, user_id: @merch_4.id )

      order_1 = user.orders.create!(created_at: 3.days.ago, updated_at: 1.day.ago)
      order_2 = user.orders.create!(created_at: 2.days.ago, updated_at: 1.day.ago)





      oi_1 = OrderItem.create!(fulfilled: false, quantity: 3, order_price: 3, order_id: order_1.id, item_id: beer_1.id, updated_at: 1.day.ago)
      oi_2 = OrderItem.create!(fulfilled: false, quantity: 6, order_price: 2, order_id: order_2.id, item_id: beer_2.id, updated_at: 1.day.ago)
      oi_3 = OrderItem.create!(fulfilled: false, quantity: 9, order_price: 4, order_id: order_2.id, item_id: beer_3.id, updated_at: 1.day.ago)






    end










  end
end
