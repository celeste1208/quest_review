FactoryBot.define do
  factory :user, class: User do
    user_name { 'user_name' }
    email     { 'email@example.com' }
    password  { 'password' }
  end
end
