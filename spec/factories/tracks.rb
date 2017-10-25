FactoryBot.define do
  factory :track do
    name { Faker::Zelda.location }
    association :sampler, factory: :sampler
  end
end