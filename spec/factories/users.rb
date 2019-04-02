FactoryBot.define do 
  factory :user do 
    sequence(:email) { |n| "fake#{n}@gmail.com"}
    role { 0 }
    enabled { false }
    name { "Fake" }
    street { "123 Street" }
    city { "Springfield "}
    state { "Illinois" }
    zip { "99999" }
    password { "password" }
  end 
end 