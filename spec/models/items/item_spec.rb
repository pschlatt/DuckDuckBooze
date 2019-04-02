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
end
