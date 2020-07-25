FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number:5) }
    post_text { Faker::Lorem.characters(number:20) }
    user
  end
end