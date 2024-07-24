FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    unit_price {  Faker::Commerce.price  }
  end
end