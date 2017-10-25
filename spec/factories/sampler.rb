FactoryBot.define do
  factory :sampler do
    title { Faker::Zelda.character }
    association :user, factory: :user

  end
end