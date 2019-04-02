FactoryBot.define do
  factory :reg_user, class: User do
    sequence(:email) { |n| "user_#{n}@gmail.com" }
    password { "password" }
    sequence(:name) { |n| "Register User Name #{n}" }
    sequence(:address) { |n| "Address #{n}" }
    sequence(:city) { |n| "City #{n}" }
    sequence(:state) { |n| "State #{n}" }
    sequence(:zip) { |n| "Zip #{n}" }
    role { 1 }
    enabled { true }
  end
  factory :visitor, parent: :user do
    sequence(:name) { |n| "Visitor User Name #{n}" }
    sequence(:email) { |n| "visitor_user_#{n}@gmail.com" }
    role { 0 }
    enabled { false }
  end

  factory :merchant, parent: :user do
    sequence(:email) { |n| "merchant_#{n}@gmail.com" }
    sequence(:name) { |n| "Merchant Name #{n}" }
    role { 2 }
    enabled { true }
  end
  factory :inactive_merchant, parent: :user do
    sequence(:email) { |n| "disabled_merchant_#{n}@gmail.com" }
    sequence(:name) { |n| "Disabled Merchant Name #{n}" }
    role { 2 }
    enabled { false }
  end

  factory :admin, parent: :user do
    sequence(:email) { |n| "admin_#{n}@gmail.com" }
    sequence(:name) { |n| "Admin Name #{n}" }
    role { 3 }
    enabled { true }
  end
end