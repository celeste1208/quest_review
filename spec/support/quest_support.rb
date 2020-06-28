module QuestSupport
  def create_quest_with(develop_id, responsible, title, content)
    visit new_quest_path
    input_form(develop_id, responsible, title, content)
    click_button '登録する'
  end

  def update_quest_with(id, develop_id, responsible, title, content)
    visit edit_quest_path(id)
    input_form(develop_id, responsible, title, content)
    click_button '更新する'
  end

  def input_form(develop_id, responsible, title, content)
    fill_in 'quest_develop_id', with: develop_id
    fill_in 'quest_responsible', with: responsible
    fill_in 'quest_title', with: title
    fill_in 'quest_content', with: content
  end

  private_class_method :input_form
end

RSpec.configure do |config|
  config.include QuestSupport
end
