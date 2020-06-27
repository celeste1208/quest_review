require 'rails_helper'

RSpec.feature 'Top', type: :feature do
  let(:user) { create(:user) }

  describe 'ヘッダーのリンクをテスト' do
    before do
      sign_in user
      visit root_path
    end

    scenario 'クエスト一覧リンクをクリックして、クエスト一覧ページに遷移する' do
      within 'header' do
        click_link('クエスト一覧')
      end
      expect(page).to have_current_path quests_path
    end

    scenario 'クエスト登録リンクをクリックして、クエスト登録ページに遷移する' do
      click_link('クエスト登録')
      expect(page).to have_current_path new_quest_path
    end

    scenario '設定リンクをクリックして、設定ページに遷移する' do
      click_link('設定')
      expect(page).to have_current_path user_path(user.id)
    end
  end
end
