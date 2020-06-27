require 'rails_helper'

RSpec.feature 'QuestComment', type: :feature do
  let(:user)     { create(:user) }
  let(:quest)    { create(:quest) }
  let!(:comment) { create(:comment, :positive, user: user, quest: quest) }

  before do
    sign_in user
    visit quest_path(quest.id)
  end

  scenario 'コメントの投稿がページに反映される', js: true do
    within page.all('.comment_form')[0] do
      fill_in 'comment_content', with: 'new_comment'
      click_button 'コメントする'
    end
    expect(page.find('p', text: 'new_comment', wait: 5)).to have_text 'new_comment'
  end

  scenario 'コメントの更新がページに反映される', js: true do
    page.find('.comment_edit_button').click
    within page.all('.comment_edit_form')[0] do
      fill_in 'comment_content', with: 'update_comment'
      click_button 'Save'
    end
    expect(page).to have_text 'update_comment'
  end

  scenario 'コメントの返信がページに反映される', js: true do
    page.find('.reply_button').click
    within page.all('.reply_form')[0] do
      fill_in 'comment_content', with: 'reply_comment'
      click_button 'Save'
    end
    expect(page).to have_text 'reply_comment'
  end

  scenario 'コメントの削除がページに反映される', js: true do
    page.accept_confirm do
      page.find('.comment_delete_button').click
    end
    expect(page).not_to have_text 'positive_content'
  end
end
