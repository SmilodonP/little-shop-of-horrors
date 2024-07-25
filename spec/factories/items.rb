FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    description { Faker::Commerce.material }
    unit_price { Faker::Number.between(from:100,to:1000000) }
    merchant { association :merchant }

  end
end