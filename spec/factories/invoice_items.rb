FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.between(from:1,to:100) }
    unit price { Faker::Commerce.price }
    status { Faker::Number.between(from:0,to:2) }
  end
end