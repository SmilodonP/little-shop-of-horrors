FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity { rand(1..20) }
    unit_price { Faker::Number.number(digits: 4)}
    status { rand(0..2) }
  end
end