FactoryBot.define do
  factory :comment do
    comment { Faker::Lorem.characters(number:20) }
    rate { Faker::Lorem.characters(number:5) }
    post
  end
end