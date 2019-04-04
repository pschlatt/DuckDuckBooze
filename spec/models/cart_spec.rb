require 'rails_helper'

RSpec.describe 'Cart' do
  describe '.total_count' do
    it 'can calculate the total number of items it holds' do
      cart = Cart.new({
        "1" => 1,
        "2" => 2,
        })

      expect(cart.total_count).to eq(3)

      cart.add_item("1")
      cart.add_item("2")

      expect(cart.contents).to eq({"1" => 2, "2" => 3})
      expect(cart.total_count).to eq(5)
    end
  end

  describe '.count_of()' do
    it 'can calculate count of specific item' do
      cart = Cart.new({})

      expect(cart.count_of(5)).to eq(0)
    end
  end
end
