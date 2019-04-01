require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :description}
    it { should validate_presence_of :stock}
    it { should validate_presence_of :item_price}
  end

  describe 'Relationships' do
    it { should belong_to :users} #merchant
    it { should have_many :order_items}
    it { should have_many(:orders).through :order_items}
  end
end
