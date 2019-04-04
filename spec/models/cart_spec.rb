require 'rails_helper'

RSpec.describe 'Cart' do
  describe '.total_count' do
    it 'can calculate the total number of items it holds' do
      cart = Cart.new({
        "Corona" => 1,
        "Bud Light" => 2,
        })

      expect(cart.total_count).to eq(3)
    end
  end
end
