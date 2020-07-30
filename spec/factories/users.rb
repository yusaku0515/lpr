FactoryBot.define do
  # 法人ユーザー
  factory :Corporation_user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    user_status { false }
    company_name { Faker::Lorem.characters(number:10) }
  end
  # 一般ユーザー
  factory :user, class: User do
  	email { Faker::Internet.email }
  	password { 'password' }
    password_confirmation { 'password' }
    user_status { true }
    family_name { "test" }
    first_name { "user" }
  end
end