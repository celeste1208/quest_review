FactoryBot.define do
  factory :user, class: User do
    sequence(:user_name) { |n| "user_name#{n}" }
    sequence(:email)     { |n| "email#{n}@example.com" }
    password             { 'password' }
  end
end
