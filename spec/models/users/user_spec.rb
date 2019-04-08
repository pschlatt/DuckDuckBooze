require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :street}
    it { should validate_presence_of :city}
    it { should validate_presence_of :state}
    it { should validate_presence_of :zip}
    it { should validate_presence_of :email}
    # it { should validate_presence_of :password}
    it { should validate_presence_of :role}

    it { should validate_uniqueness_of :email}
    it { should validate_inclusion_of(:enabled).in_array([true, false])}
  end

  describe 'Relationships' do
    it { should have_many :items} #merchants
    it { should have_many :orders}
  end

  describe "roles" do
    it "can be created as an admin" do
      @user = create(:user)
      @user.update(role: 3)

      expect(@user.role).to eq("admin")
      expect(@user.admin?).to be_truthy
    end

    it "can be created as an merchant" do
      @user = create(:user)
      @user.update(role: 2)

      expect(@user.role).to eq("merchant")
      expect(@user.merchant?).to be_truthy
    end

    it "can be created as an registered_user" do
      @user = create(:user)
      @user.update(role: 1)

      expect(@user.role).to eq("registered_user")
      expect(@user.registered_user?).to be_truthy
    end
  end

  describe 'As a Merchant' do
    context '#avg_fill_time' do
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
  #
  # describe 'merchant index page stats' do
  #   before :each do
  #     @user_1 = create(:user, state: "CO", city: "Denver")
  #     @user_2 = create(:user, state: "WA", city: "Seattle")
  #     @user_3 = create(:user, state: "HI", city: "Honolulu")
  #     @user_4 = create(:user, state: "CO", city: "Boulder")
  #     @user_5 = create(:user, state: "WA", city: "Seattle")
  #
  #     @merch_1 = create(:merchant, name: "Mike")
  #     @merch_2 = create(:merchant, name: "Tom")
  #     @merch_3 = create(:merchant, name: "Joe")
  #     @merch_4 = create(:merchant, name: "Bob")
  #
  #     @beer_1 = Item.create!(name: "MGD", description: "good beer", stock: 120, item_price: 1.5, user_id: @merch_1.id )
  #     @beer_2 = Item.create!(name: "Mich Ultra", description: "better beer", stock: 150, item_price: 2.5, user_id: @merch_2.id )
  #     @beer_3 = Item.create!(name: "4 Noses", description: "yummy beer", stock: 180, item_price: 3.5, user_id: @merch_3.id )
  #     @beer_4 = Item.create!(name: "Guiness", description: "the best", stock: 180, item_price: 3.5, user_id: @merch_4.id )
  #
  #     @order_1 = @user_1.orders.create!(status: 'shipped', created_at: 5.days.ago, updated_at: 1.day.ago)
  #     @order_2 = @user_2.orders.create!(status: 'shipped', created_at: 6.days.ago, updated_at: 1.day.ago)
  #     @order_3 = @user_3.orders.create!(status: 'shipped', created_at: 4.days.ago, updated_at: 1.day.ago)
  #     @order_4 = @user_4.orders.create!(status: 'shipped', created_at: 3.days.ago, updated_at: 1.day.ago)
  #     @order_5 = @user_5.orders.create!(status: 'shipped', created_at: 2.days.ago, updated_at: 1.day.ago)
  #     @order_6 = @user_1.orders.create!(status: 'shipped', created_at: 10.days.ago, updated_at: 1.day.ago)
  #
  #     @oi_1 = OrderItem.create!(fulfilled: true, quantity: 3, order_price: 3, order_id: @order_1.id, item_id: @beer_1.id, created_at: 5.days.ago, updated_at: 1.day.ago)
  #     # $9 - merch_1
  #     @oi_2 = OrderItem.create!(fulfilled: true, quantity: 6, order_price: 2, order_id: @order_1.id, item_id: @beer_2.id, created_at: 5.days.ago, updated_at: 1.day.ago)
  #     # $12 - merch_2
  #     @oi_3 = OrderItem.create!(fulfilled: true, quantity: 9, order_price: 4, order_id: @order_2.id, item_id: @beer_3.id, created_at: 6.days.ago, updated_at: 1.day.ago)
  #     # $36 - merch_3
  #     @oi_4 = OrderItem.create!(fulfilled: true, quantity: 11, order_price: 5, order_id: @order_2.id, item_id: @beer_4.id, created_at: 6.days.ago, updated_at: 1.day.ago)
  #     # $55 - merch_4
  #     @oi_5 = OrderItem.create!(fulfilled: true, quantity: 4, order_price: 4, order_id: @order_3.id, item_id: @beer_1.id, created_at: 4.days.ago, updated_at: 1.day.ago)
  #     # $16 - merch_1
  #     @oi_6 = OrderItem.create!(fulfilled: true, quantity: 10, order_price: 8, order_id: @order_4.id, item_id: @beer_2.id, created_at: 3.days.ago, updated_at: 1.day.ago)
  #     # $80 - merch_2
  #     @oi_7 = OrderItem.create!(fulfilled: true, quantity: 25, order_price: 10, order_id: @order_5.id, item_id: @beer_3.id, created_at: 2.days.ago, updated_at: 1.day.ago)
  #     # $250 - merch_3
  #     @oi_8 = OrderItem.create!(fulfilled: true, quantity: 1, order_price: 4, order_id: @order_6.id, item_id: @beer_4.id, created_at: 10.days.ago, updated_at: 1.day.ago)
  #
  #     # @oi_1 = OrderItem.create!(fulfilled: true, quantity: 3, order_price: 3, order_id: @order_1.id, item_id: @beer_1.id, updated_at: 1.day.ago)
  #     # # $9 - merch_1
  #     # @oi_2 = OrderItem.create!(fulfilled: true, quantity: 6, order_price: 2, order_id: @order_1.id, item_id: @beer_2.id, updated_at: 1.day.ago)
  #     # # $12 - merch_2
  #     # @oi_3 = OrderItem.create!(fulfilled: true, quantity: 9, order_price: 4, order_id: @order_2.id, item_id: @beer_3.id, updated_at: 1.day.ago)
  #     # # $36 - merch_3
  #     # @oi_4 = OrderItem.create!(fulfilled: true, quantity: 11, order_price: 5, order_id: @order_2.id, item_id: @beer_4.id, updated_at: 1.day.ago)
  #     # # $55 - merch_4
  #     # @oi_5 = OrderItem.create!(fulfilled: true, quantity: 4, order_price: 4, order_id: @order_3.id, item_id: @beer_1.id, updated_at: 1.day.ago)
  #     # # $16 - merch_1
  #     # @oi_6 = OrderItem.create!(fulfilled: true, quantity: 10, order_price: 8, order_id: @order_4.id, item_id: @beer_2.id, updated_at: 1.day.ago)
  #     # # $80 - merch_2
  #     # @oi_7 = OrderItem.create!(fulfilled: true, quantity: 25, order_price: 10, order_id: @order_5.id, item_id: @beer_3.id, updated_at: 1.day.ago)
  #     # # $250 - merch_3
  #     # @oi_8 = OrderItem.create!(fulfilled: true, quantity: 1, order_price: 4, order_id: @order_6.id, item_id: @beer_4.id, updated_at: 1.day.ago)
  #     # # $4 - merch_4
  #   end
  #
  #   it '.top_three_rev' do
  #
  #     expect(User.top_three_rev).to eq([@merch_3, @merch_2, @merch_4])
  #   end
  #
  #   it '.top_three_fast' do
  #
  #     expect(User.top_three_fast).to eq([@merch_3, @merch_2, @merch_1])
  #   end
  # end
end
