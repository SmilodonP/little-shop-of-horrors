FactoryBot.define do
  factory :invoice do
    status { Faker::Number.between(from:0,to:2) }
    customer { association :customer}
  end
end