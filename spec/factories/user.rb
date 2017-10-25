FactoryBot.define do
  factory :user do
    display_name { Faker::StarTrek.character }
    email { Faker::Internet.safe_email }
    spotify_id { Faker::Internet.user_name(display_name) }
    profile_pic_url { Faker::Avatar.image(spotify_id, "300x300", "png", "set4", "bg2") }
  end
end