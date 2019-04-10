require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :status}
  end

  describe 'Relationships' do
    it { should belong_to :user}
    it { should have_many :order_items}
    it { should have_many(:items).through :order_items}
  end

  describe 'Status' do
    it 'can be a packaged order' do
      order = create(:order)
      order.update(status: 1)

      expect(order.status).to eq('packaged')
      expect(order.packaged?).to be_truthy
    end

    it 'can be a shipped order' do
      order = create(:order)
      order.update(status: 2)

      expect(order.status).to eq('shipped')
      expect(order.shipped?).to be_truthy
    end

    it 'can be a cancelled order' do
      order = create(:order)
      order.update(status: 3)

      expect(order.status).to eq('cancelled')
      expect(order.cancelled?).to be_truthy
    end
  end
  describe 'order_stats' do
    before :each do
      @user_11 = User.create(role: 1, enabled: false, name: "Sally Shopper", street: "123 Busy Way", city: "Denver", state: "CO", zip: "80222", email: "sally@gmail.com", password: "12345678")
      @user_12 = create(:user)
      @merchant_1 = User.create(role: 2, enabled: true, name: "Mike Merchant", street: "1 Old Street", city: "Golden", state: "CO", zip: "80403", email: "mike@gmail.com", password: "password")

      @beer_1 = @merchant_1.items.create(name: "Heineken", description: "Pale lager, 5%", item_price: 4.00, stock: 56, enabled: true, image: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/Heineken.jpg/156px-Heineken.jpg")
      @beer_2 = @merchant_1.items.create(name: "Guiness", description: "Pale lager, 5%", item_price: 4.00, stock: 56, enabled: true, image: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/Heineken.jpg/156px-Heineken.jpg")

      @order_1 = @user_11.orders.create(status: 0)
      @order_2 = @user_11.orders.create(status: 0)
      @order_3 = @user_11.orders.create(status: 0)
      @order_4 = @user_12.orders.create(status: 0)

      @order_item_1 = OrderItem.create(item_id: @beer_1.id, order_id: @order_1.id, fulfilled: true, quantity: 3, order_price: 5.22, created_at: 2.days.ago, updated_at: 1.day.ago)
      @order_item_2 = OrderItem.create(item_id: @beer_1.id, order_id: @order_1.id, fulfilled: true, quantity: 12, order_price: 15.62, created_at: 3.days.ago, updated_at: 1.day.ago)
      @order_item_3 = OrderItem.create(item_id: @beer_1.id, order_id: @order_2.id, fulfilled: true, quantity: 24, order_price: 29.05, created_at: 4.days.ago, updated_at: 1.day.ago)
      @order_item_4 = OrderItem.create(item_id: @beer_2.id, order_id: @order_4.id, fulfilled: true, quantity: 24, order_price: 29.05, created_at: 30.days.ago, updated_at: 1.day.ago)
    end

    it '#order_quantity' do

      expect(@order_1.order_quantity(@order_1.id)).to eq(15)
      expect(@order_2.order_quantity(@order_2.id)).to eq(24)
    end

    it '#order_grand_total' do

      expect(@order_1.order_grand_total(@order_1)).to eq(203.10)
      expect(@order_2.order_grand_total(@order_2)).to eq(697.20)
    end
  end

  describe 'merchant orders totals' do
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
      @order_4 = create(:shipped_order, user_id: @user_2.id)
      @order_item_1 = OrderItem.create(quantity: 16, order_price: 12.0, order_id: @order_1.id, item_id: @item_1.id)
      @order_item_2 = OrderItem.create(quantity: 24, order_price: 23.0, order_id: @order_1.id, item_id: @item_2.id)
      @order_item_3 = OrderItem.create(quantity: 33, order_price: 34.0, order_id: @order_2.id, item_id: @item_3.id)
      @order_item_4 = OrderItem.create(quantity: 45, order_price: 42.0, order_id: @order_3.id, item_id: @item_3.id)
      @order_item_5 = OrderItem.create(quantity: 57, order_price: 53.0, order_id: @order_4.id, item_id: @item_4.id)
    end

    it '#merchant_order_total' do
      expect(@order_1.merchant_order_total(@order_1)).to eq(40)
      expect(@order_2.merchant_order_total(@order_2)).to eq(33)
      expect(@order_3.merchant_order_total(@order_3)).to eq(45)
    end

    it '#merchant_order_total_price' do
      expect(@order_1.merchant_order_total_price(@order_1)).to eq(744.0)
      expect(@order_2.merchant_order_total_price(@order_2)).to eq(1122.0)
      expect(@order_3.merchant_order_total_price(@order_3)).to eq(1890.0)
    end
  end
  describe 'merchant index page stats' do
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
    end

    it '.largest_3_orders'do

      expect(Order.largest_3_orders).to eq([@order_5, @order_2, @order_4])
    end
  end
  describe 'cancel orders' do
    it '#change_oi_status'do
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

      order_1.change_oi_status(order_1)
      order_1.reload
      oi_1.reload
      oi_2.reload
      expect(oi_1.fulfilled).to eq(false)
      expect(oi_2.fulfilled).to eq(false)
    end
    it '#restock_items' do
      user = create(:user)
      merchant = create(:merchant)
      beer_1 = Item.create!(name: "MGD", description: "good beer", stock: 12, item_price: 1.5, user_id: merchant.id )
      beer_2 = Item.create!(name: "Mich Ultra", description: "better beer", stock: 15, item_price: 2.5, user_id: merchant.id )
      order_1 = user.orders.create!(created_at: 3.days.ago, updated_at: 1.day.ago)
      oi_1 = OrderItem.create!(fulfilled: true, quantity: 3, order_price: 3, order_id: order_1.id, item_id: beer_1.id, updated_at: 1.day.ago)
      oi_2 = OrderItem.create!(fulfilled: false, quantity: 6, order_price: 2, order_id: order_1.id, item_id: beer_2.id, updated_at: 1.day.ago)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      order_1.restock_items(order_1)
      order_1.reload
      oi_1.reload
      oi_2.reload
      beer_1.reload
      beer_2.reload
      expect(beer_1.stock).to eq(15)
      expect(beer_2.stock).to eq(21)
    end
  end
end
