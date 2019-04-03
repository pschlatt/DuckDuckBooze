require 'rails_helper'

RSpec.describe 'Item Show Page', type: :feature do
  before :each do
    @user_11 = User.create(role: 1, enabled: false, name: "Sally Shopper", street: "123 Busy Way", city: "Denver", state: "CO", zip: "80222", email: "sally@gmail.com", password: "12345678")
    @user_12 = User.create(role: 1, enabled: false, name: "Sam Spender", street: "1 Old Street", city: "Golden", state: "CO", zip: "80403", email: "sam@gmail.com", password: "password")

    @merchant_1 = User.create(role: 2, enabled: true, name: "Mike Merchant", street: "1 Old Street", city: "Golden", state: "CO", zip: "80403", email: "mike@gmail.com", password: "password")

    @beer_1 = @merchant_1.items.create(name: "Heineken", description: "Pale lager, 5%", item_price: 4.00, stock: 56, enabled: true, image: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/Heineken.jpg/156px-Heineken.jpg")

    @order_1 = @user_11.orders.create(status: 0)
    @order_2 = @user_12.orders.create(status: 0)

    @order_item = OrderItem.create(item_id: @beer_1.id, order_id: @order_1.id, fulfilled: true, quantity: 12, order_price: 15.62, created_at: 2.days.ago, updated_at: 1.day.ago)
    #class method - avg time where name = hein
  end

  describe 'any visitor who visits an items show page' do
    it 'shows the name, description, and large image of the item' do

      visit item_path(@beer_1)

      expect(page).to have_content(@beer_1.name)
      expect(page).to have_xpath("//img[@src='#{@beer_1.image}']")
    end

    it 'shows the name of the merchant, their stock of the item, and the current item price' do

      visit item_path(@beer_1)

      within '#item-show-merchant-info' do
        expect(page).to have_content("Merchant: #{@merchant_1.name}")
        expect(page).to have_content("Stock: #{@beer_1.stock}")
      end
    end

    it 'shows the average amount of time for the merchant to fulfill this item' do

      visit item_path(@beer_1)

      within '#item-show-merchant-info' do
        expect(page).to have_content("Average Fulfillment Time: #{@merchant_1.name}")
      end
    end
  end

  describe 'as a visitor or regular user' do
    it 'shows a button to add this item to my cart' do

      visit item_path(@beer_1)
      save_and_open_page
      expect(page).to have_button('Add to Cart')
    end
  end
end
