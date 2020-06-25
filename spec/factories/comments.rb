FactoryBot.define do
  factory :comment, class: Comment do
    content      { 'content' }
    opinion_type { 'opinion_type' }
    association :user
    association :quest

    trait :positive do
      content      { 'positive_content' }
      opinion_type { 'positive' }
    end

    trait :negative do
      content      { 'negative_content' }
      opinion_type { 'negative' }
    end

    trait :question do
      content      { 'question_content' }
      opinion_type { 'question' }
    end
  end
end
