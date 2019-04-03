FactoryBot.define do
  factory :user, class User do
    sequence(:email) { |n| "user_#{n}@gmail.com" }
    password { "password" }
    sequence(:name) { |n| "User Name #{n}" }
    sequence(:street) { |n| "Address #{n}" }
    sequence(:city) { |n| "City #{n}" }
    sequence(:state) { |n| "State #{n}" }
    sequence(:zip) { |n| "Zip #{n}" }
    role { 1 }
    enabled { true }
  end
  factory :disabled_user, parent: :user do
    sequence(:name) { |n| "Disabled User Name #{n}" }
    sequence(:email) { |n| "Disabled_user_#{n}@gmail.com" }
    enabled { false }
  end

  factory :merchant, parent: :user do
    sequence(:email) { |n| "merchant_#{n}@gmail.com" }
    sequence(:name) { |n| "Merchant Name #{n}" }
    role { 2 }
    enabled { true }
  end
  factory :disabled_merchant, parent: :user do
    sequence(:email) { |n| "Disabled_merchant_#{n}@gmail.com" }
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
