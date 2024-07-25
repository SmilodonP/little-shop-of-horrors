FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    description { Faker::Commerce.material }
    unit_price { Faker::Number.between(1..1000000)} # Might want to try 2 methods
    # unit_price { Faker::Number.between(from:1, to: 1000000)} # One of these should work
    merchant { association :merchant }
  end
end
