FactoryBot.define do
  factory :quest, class: Quest do
    develop_id  { 1 }
    title       { 'title' }
    responsible { 'responsible' }
  end
end
