FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    description { Faker::Commerce.material }
    unit_price { Faker::Commerce.price }
    merchant { association :merchant }
  end
end