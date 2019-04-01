require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :fulfilled}
    it { should validate_presence_of :quantity}
    it { should validate_presence_of :order_price}

    it { should validate_numericality_of :quantity}
    it { should validate_inclusion_of :state, in: [true, false]}
  end

  describe 'Relationships' do
    it { belongs_to :order}
    it { belongs_to :item}
  end
end
