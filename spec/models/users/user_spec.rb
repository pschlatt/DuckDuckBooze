require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :street}
    it { should validate_presence_of :city}
    it { should validate_presence_of :state}
    it { should validate_presence_of :zip}
    it { should validate_presence_of :email}
    it { should validate_presence_of :password}
    it { should validate_presence_of :role}
    it { should validate_inclusion_of(:enabled).in_array([true, false])}

    it { should validate_uniqueness_of :email}
    it { should validate_inclusion_of(:enabled).in_array([true, false])}
    # it { should validate_numericality_of :role}
    # it { should validate_inclusion_of(:role).in_array([0,1,2,3])}
  end

  describe 'Relationships' do
    it { should have_many :items} #merchants
    it { should have_many :orders}
  end

  describe 'As a Merchant' do
    context '.avg_fill_time' do
     it 'calculates the average time to fulfill an order of a specific item' do

       @user_11 = User.create(role: 1, enabled: false, name: "Sally Shopper", street: "123 Busy Way", city: "Denver", state: "CO", zip: "80222", email: "sally@gmail.com", password: "12345678")
       @merchant_1 = User.create(role: 2, enabled: true, name: "Mike Merchant", street: "1 Old Street", city: "Golden", state: "CO", zip: "80403", email: "mike@gmail.com", password: "password")

       @beer_1 = @merchant_1.items.create(name: "Heineken", description: "Pale lager, 5%", item_price: 4.00, stock: 56, enabled: true, image: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/Heineken.jpg/156px-Heineken.jpg")
       @beer_2 = @merchant_1.items.create(name: "Guiness", description: "Pale lager, 5%", item_price: 4.00, stock: 56, enabled: true, image: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/Heineken.jpg/156px-Heineken.jpg")

       @order_1 = @user_11.orders.create(status: 0)
       @order_2 = @user_11.orders.create(status: 0)
       @order_3 = @user_11.orders.create(status: 0)
       @order_4 = @user_11.orders.create(status: 0)

       @order_item_1 = OrderItem.create(item_id: @beer_1.id, order_id: @order_1.id, fulfilled: true, quantity: 3, order_price: 5.22, created_at: 2.days.ago, updated_at: 1.day.ago)
       @order_item_2 = OrderItem.create(item_id: @beer_1.id, order_id: @order_1.id, fulfilled: true, quantity: 12, order_price: 15.62, created_at: 3.days.ago, updated_at: 1.day.ago)
       @order_item_3 = OrderItem.create(item_id: @beer_1.id, order_id: @order_1.id, fulfilled: true, quantity: 24, order_price: 29.05, created_at: 4.days.ago, updated_at: 1.day.ago)
       @order_item_4 = OrderItem.create(item_id: @beer_2.id, order_id: @order_2.id, fulfilled: true, quantity: 24, order_price: 29.05, created_at: 30.days.ago, updated_at: 1.day.ago)

       expect(@merchant_1.avg_fill_time(@beer_1)).to eq(48)
     end
    end
  end
end
