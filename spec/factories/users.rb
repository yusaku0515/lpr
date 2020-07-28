FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    user_status { false }
    company_name { Faker::Lorem.characters(number:10) }

  end
end