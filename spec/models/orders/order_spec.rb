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
end
