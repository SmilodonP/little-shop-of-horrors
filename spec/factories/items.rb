FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    unit price { { Faker::Commerce.price } }
  end
end