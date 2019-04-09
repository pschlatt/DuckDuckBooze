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
      @user_1 = create(:user, state: "CO", city: "Denver")
      @user_2 = create(:user, state: "WA", city: "Seattle")
      @user_3 = create(:user, state: "HI", city: "Honolulu")
      @user_4 = create(:user, state: "CO", city: "Boulder")
      @user_5 = create(:user, state: "WA", city: "Seattle")

      @merch_1 = create(:merchant, name: "Mike")
      @merch_2 = create(:merchant, name: "Tom")
      @merch_3 = create(:merchant, name: "Joe")
      @merch_4 = create(:merchant, name: "Bob")

      @beer_1 = Item.create!(name: "MGD", description: "good beer", stock: 120, item_price: 1.5, user_id: @merch_1.id )
      @beer_2 = Item.create!(name: "Mich Ultra", description: "better beer", stock: 150, item_price: 2.5, user_id: @merch_2.id )
      @beer_3 = Item.create!(name: "4 Noses", description: "yummy beer", stock: 180, item_price: 3.5, user_id: @merch_3.id )
      @beer_4 = Item.create!(name: "Guiness", description: "the best", stock: 180, item_price: 3.5, user_id: @merch_4.id )

      @order_1 = @user_1.orders.create!(status: 'shipped', created_at: 5.days.ago, updated_at: 1.day.ago)
      @order_2 = @user_2.orders.create!(status: 'shipped', created_at: 6.days.ago, updated_at: 1.day.ago)
      @order_3 = @user_3.orders.create!(status: 'shipped', created_at: 4.days.ago, updated_at: 1.day.ago)
      @order_4 = @user_4.orders.create!(status: 'shipped', created_at: 3.days.ago, updated_at: 1.day.ago)
      @order_5 = @user_5.orders.create!(status: 'shipped', created_at: 2.days.ago, updated_at: 1.day.ago)
      @order_6 = @user_1.orders.create!(status: 'shipped', created_at: 10.days.ago, updated_at: 1.day.ago)


      @oi_1 = OrderItem.create!(fulfilled: true, quantity: 3, order_price: 3, order_id: @order_1.id, item_id: @beer_1.id, created_at: 5.days.ago, updated_at: 1.day.ago)
      # $9 - merch_1
      @oi_2 = OrderItem.create!(fulfilled: true, quantity: 6, order_price: 2, order_id: @order_1.id, item_id: @beer_2.id, created_at: 5.days.ago, updated_at: 1.day.ago)
      # $12 - merch_2
      @oi_3 = OrderItem.create!(fulfilled: true, quantity: 9, order_price: 4, order_id: @order_2.id, item_id: @beer_3.id, created_at: 8.days.ago, updated_at: 1.day.ago)
      # $36 - merch_3
      @oi_4 = OrderItem.create!(fulfilled: true, quantity: 11, order_price: 5, order_id: @order_2.id, item_id: @beer_4.id, created_at: 6.days.ago, updated_at: 1.day.ago)
      # $55 - merch_4
      @oi_5 = OrderItem.create!(fulfilled: true, quantity: 4, order_price: 4, order_id: @order_3.id, item_id: @beer_1.id, created_at: 4.days.ago, updated_at: 1.day.ago)
      # $16 - merch_1
      @oi_6 = OrderItem.create!(fulfilled: true, quantity: 10, order_price: 8, order_id: @order_4.id, item_id: @beer_2.id, created_at: 3.days.ago, updated_at: 1.day.ago)
      # $80 - merch_2
      @oi_7 = OrderItem.create!(fulfilled: true, quantity: 25, order_price: 10, order_id: @order_5.id, item_id: @beer_3.id, created_at: 2.days.ago, updated_at: 1.day.ago)
      # $250 - merch_3
      @oi_8 = OrderItem.create!(fulfilled: true, quantity: 1, order_price: 4, order_id: @order_6.id, item_id: @beer_4.id, created_at: 10.days.ago, updated_at: 1.day.ago)
      # $4 - merch_4
      visit merchants_path
    end

    it 'shows top three merchants by revenue' do
      within "#top-three-rev" do

        expect(page.all('li')[0]).to have_content("#{@merch_3.name} - $286.00")
        expect(page.all('li')[1]).to have_content("#{@merch_2.name} - $92.00")
        expect(page.all('li')[2]).to have_content("#{@merch_4.name} - $59.00")
      end
    end

    it 'shows top three fastest merchants on fulfillment time' do
      within "#top-three-fastest" do

        expect(page.all('li')[0]).to have_content("#{@merch_2.name} - 3 days")
        expect(page.all('li')[1]).to have_content("#{@merch_1.name} - 3 days")
        expect(page.all('li')[2]).to have_content("#{@merch_3.name} - 4 days")
      end
    end

    it 'shows bottom three fastest merchants on fulfillment time' do
      within "#bot-three-fastest" do
        expect(page.all('li')[0]).to have_content("#{@merch_4.name} - 7 days")
        expect(page.all('li')[1]).to have_content("#{@merch_3.name} - 4 days")
        expect(page.all('li')[2]).to have_content("#{@merch_1.name} - 3 days")
      end
    end

    xit 'shows top three states by number of orders' do
      within "#top-three-states" do
        expect(page.all('li')[0]).to have_content("#{merch_3.name}")
        expect(page.all('li')[1]).to have_content("#{merch_2.name}")
        expect(page.all('li')[2]).to have_content("#{merch_4.name}")
      end
    end

    it 'shows top three cities by number of orders' do
      user_1 = create(:user, state: "CO", city: "Denver")
      user_2 = create(:user, state: "WA", city: "Seattle")
      user_3 = create(:user, state: "CO", city: "Denver")
      user_4 = create(:user, state: "CO", city: "Boulder")
      user_5 = create(:user, state: "WA", city: "Seattle")

      merch_1 = create(:merchant, name: "Mike")
      merch_2 = create(:merchant, name: "Tom")
      merch_3 = create(:merchant, name: "Joe")
      merch_4 = create(:merchant, name: "Bob")

      beer_1 = Item.create!(name: "MGD", description: "good beer", stock: 120, item_price: 1.5, user_id: merch_1.id )
      beer_2 = Item.create!(name: "Mich Ultra", description: "better beer", stock: 150, item_price: 2.5, user_id: merch_2.id )
      beer_3 = Item.create!(name: "4 Noses", description: "yummy beer", stock: 180, item_price: 3.5, user_id: merch_3.id )
      beer_4 = Item.create!(name: "Guiness", description: "the best", stock: 180, item_price: 3.5, user_id: merch_4.id )

      order_1 = user_1.orders.create!(status: 'shipped', created_at: 5.days.ago, updated_at: 1.day.ago)
      order_2 = user_2.orders.create!(status: 'shipped', created_at: 6.days.ago, updated_at: 1.day.ago)
      order_3 = user_3.orders.create!(status: 'shipped', created_at: 4.days.ago, updated_at: 1.day.ago)
      order_4 = user_4.orders.create!(status: 'shipped', created_at: 3.days.ago, updated_at: 1.day.ago)
      order_5 = user_5.orders.create!(status: 'shipped', created_at: 2.days.ago, updated_at: 1.day.ago)
      order_6 = user_1.orders.create!(status: 'shipped', created_at: 10.days.ago, updated_at: 1.day.ago)


      oi_1 = OrderItem.create!(fulfilled: true, quantity: 3, order_price: 3, order_id: order_1.id, item_id: beer_1.id, created_at: 5.days.ago, updated_at: 1.day.ago)
      oi_2 = OrderItem.create!(fulfilled: true, quantity: 6, order_price: 2, order_id: order_1.id, item_id: beer_2.id, created_at: 5.days.ago, updated_at: 1.day.ago)
      oi_3 = OrderItem.create!(fulfilled: true, quantity: 9, order_price: 4, order_id: order_2.id, item_id: beer_3.id, created_at: 8.days.ago, updated_at: 1.day.ago)
      oi_4 = OrderItem.create!(fulfilled: true, quantity: 11, order_price: 5, order_id: order_2.id, item_id: beer_4.id, created_at: 6.days.ago, updated_at: 1.day.ago)
      oi_5 = OrderItem.create!(fulfilled: true, quantity: 4, order_price: 4, order_id: order_3.id, item_id: beer_1.id, created_at: 4.days.ago, updated_at: 1.day.ago)
      oi_6 = OrderItem.create!(fulfilled: true, quantity: 10, order_price: 8, order_id: order_4.id, item_id: beer_2.id, created_at: 3.days.ago, updated_at: 1.day.ago)
      oi_7 = OrderItem.create!(fulfilled: true, quantity: 25, order_price: 10, order_id: order_5.id, item_id: beer_3.id, created_at: 2.days.ago, updated_at: 1.day.ago)
      oi_8 = OrderItem.create!(fulfilled: true, quantity: 1, order_price: 4, order_id: order_6.id, item_id: beer_4.id, created_at: 10.days.ago, updated_at: 1.day.ago)

      save_and_open_page
      within "#top-three-cities" do
        expect(page.all('li')[0]).to have_content("Denver - 3")
        expect(page.all('li')[1]).to have_content("Seattle - 2")
        expect(page.all('li')[2]).to have_content("Boulder - 1")
      end
    end

    it 'shows three largest orders by quantity' do
      within "#top-three-order-quantity" do
        expect(page.all('li')[0]).to have_content("Order number: #{@order_5.id} - 25")
        expect(page.all('li')[1]).to have_content("Order number: #{@order_2.id} - 20")
        expect(page.all('li')[2]).to have_content("Order number: #{@order_4.id} - 10")
      end
    end
  end
end
