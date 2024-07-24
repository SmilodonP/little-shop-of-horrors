FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Finance.credit_card }
    credit_card_expiration_date { Faker::Business.credit_card_expiry_date }
    result { Faker::Number.between(from:0,to:1) }
  end
end