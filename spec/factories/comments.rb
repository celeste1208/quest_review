FactoryBot.define do
  factory :comment, class: Comment do
    content      { 'content' }
    opinion_type { 'opinion_type' }
    association :user
    association :quest
  end
end
