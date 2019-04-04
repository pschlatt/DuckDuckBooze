require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :description}
    it { should validate_presence_of :stock}
    it { should validate_presence_of :item_price}
    # it { should validate_presence_of :image}

    it { should validate_numericality_of :stock}
    it { should validate_numericality_of :item_price}
    it { should validate_inclusion_of(:enabled).in_array([true, false])}
  end

  describe 'Relationships' do
    it { should belong_to :user} #merchant
    it { should have_many :order_items}
    it { should have_many(:orders).through :order_items}
  end

  describe 'Class methods' do
    before :each do
      @item_1 = create(:item)
      @item_2 = create(:item)
      @item_3 = create(:item)
      @item_4 = create(:item)
      @item_5 = create(:item)
      @item_6 = create(:item)
      @item_7 = create(:item)
      @order_1 = create(:shipped_order)
      @order_2 = create(:shipped_order)
      @order_3 = create(:shipped_order)
      @order_4 = create(:shipped_order)
      @order_5 = create(:shipped_order)
      @order_6 = create(:shipped_order)
      @order_7 = create(:shipped_order)
      @order_item_1 = OrderItem.create(fulfilled: true, quantity: 3, order_price: 2.0, order_id: @order_1.id, item_id: @item_1.id)
      @order_item_2 = OrderItem.create(fulfilled: true, quantity: 4, order_price: 2.0, order_id: @order_2.id, item_id: @item_2.id)
      @order_item_3 = OrderItem.create(fulfilled: true, quantity: 5, order_price: 2.0, order_id: @order_3.id, item_id: @item_3.id)
      @order_item_4 = OrderItem.create(fulfilled: true, quantity: 6, order_price: 2.0, order_id: @order_4.id, item_id: @item_4.id)
      @order_item_5 = OrderItem.create(fulfilled: true, quantity: 7, order_price: 2.0, order_id: @order_5.id, item_id: @item_5.id)
      @order_item_6 = OrderItem.create(fulfilled: true, quantity: 8, order_price: 2.0, order_id: @order_6.id, item_id: @item_6.id)
      @order_item_7 = OrderItem.create(fulfilled: true, quantity: 9, order_price: 2.0, order_id: @order_7.id, item_id: @item_7.id)
    end

    describe '.five_stats' do
      it 'shows top stats' do

        expect(Item.five_stats(:desc).first.name).to eq(@item_7.name)
        expect(Item.five_stats(:desc).first.quantity).to eq(@order_item_7.quantity)
        expect(Item.five_stats(:desc).second.name).to eq(@item_6.name)
        expect(Item.five_stats(:desc).second.quantity).to eq(@order_item_6.quantity)
        expect(Item.five_stats(:desc).third.name).to eq(@item_5.name)
        expect(Item.five_stats(:desc).third.quantity).to eq(@order_item_5.quantity)
        expect(Item.five_stats(:desc).fourth.name).to eq(@item_4.name)
        expect(Item.five_stats(:desc).fourth.quantity).to eq(@order_item_4.quantity)

      end

      it 'shows bottom stats' do

        expect(Item.five_stats(:asc).first.name).to eq(@item_1.name)
        expect(Item.five_stats(:asc).first.quantity).to eq(@order_item_1.quantity)
        expect(Item.five_stats(:asc).second.name).to eq(@item_2.name)
        expect(Item.five_stats(:asc).second.quantity).to eq(@order_item_2.quantity)
        expect(Item.five_stats(:asc).third.name).to eq(@item_3.name)
        expect(Item.five_stats(:asc).third.quantity).to eq(@order_item_3.quantity)
        expect(Item.five_stats(:asc).fourth.name).to eq(@item_4.name)
        expect(Item.five_stats(:asc).fourth.quantity).to eq(@order_item_4.quantity)
      end
    end
  end
end
