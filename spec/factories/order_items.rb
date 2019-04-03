FactoryBot.define do
  factory :order_items do
    order
    item
    sequence(:quantity) { |n| ("#{n}".to_i+1)*2 }
    sequence(:order_price) { |n| ("#{n}".to_i+1)*1.5 }
    fulfilled { false }
  end
  factory :fulfilled_order_items, parent: :order_items do
    fulfilled { true }
  end
end
