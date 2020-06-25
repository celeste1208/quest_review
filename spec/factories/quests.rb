FactoryBot.define do
  factory :quest, class: Quest do
    sequence(:develop_id)  { |n| n }
    title                  { 'quest_title' }
    responsible            { 'quest_responsible' }
    content                { 'quest_content' }
  end
end
