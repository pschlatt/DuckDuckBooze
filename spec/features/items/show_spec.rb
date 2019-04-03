require 'rails_helper'

RSpec.describe 'Item Show Page', type: :feature do
  describe 'any visitor who visits an items show page' do
    before :each do
      @user_11 = User.create(role: 1, enabled: false, name: "Sally Shopper", street: "123 Busy Way", city: "Denver", state: "CO", zip: "80222", email: "sally@gmail.com", password: "12345678")
      @user_12 = User.create(role: 1, enabled: false, name: "Sam Spender", street: "1 Old Street", city: "Golden", state: "CO", zip: "80403", email: "sam@gmail.com", password: "password")

      @merchant_1 = User.create(role: 2, enabled: true, name: "Mike Merchant", street: "1 Old Street", city: "Golden", state: "CO", zip: "80403", email: "mike@gmail.com", password: "password")

      @beer_1 = @merchant_1.items.create(name: "Heineken", description: "Pale lager, 5%", item_price: 4.00, stock: 56, enabled: true, image: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/Heineken.jpg/156px-Heineken.jpg")

      @order_1 = @user_11.orders.create(status: 0)
      @order_2 = @user_12.orders.create(status: 0)

      @order_item = OrderItem.create(item_id: @beer_1.id, order_id: @order_1.id, fulfilled: true, quantity: 12, order_price: 15.62, created_at: 2.days.ago, updated_at: 1.day.ago)
      #need to clear test data

      #class method - avg time where name = hein

    end
    it 'shows the name, description, and large image of the item' do

      visit item_path(@beer_1)


    end

    it 'shows the name of the merchant, their stock of the item, and the current item price' do
    end

    it 'shows the average amount of time for the merchant to fulfill this item' do
    end
  end

  describe 'as a visitor or regular user' do
    it 'shows a link to add this item to my cart' do
    end
  end
end
