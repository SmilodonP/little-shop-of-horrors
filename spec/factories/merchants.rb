FactoryBot.define do
  factory :merchant do
    name { Faker::Name.name }

    trait :enabled do
      status { :enabled }
    end

    trait :disabled do
      status { :disabled }
    end
  end
end