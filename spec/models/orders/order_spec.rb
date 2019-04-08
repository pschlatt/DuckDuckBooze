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
end
