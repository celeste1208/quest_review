require 'rails_helper'

RSpec.feature 'Quest', type: :feature do
  let(:user)     { create(:user) }
  let(:quest)    { create(:quest) }
  let!(:comment) { create(:comment, :positive, user: user, quest: quest) }

  before do
    sign_in user
  end

  describe 'クエストへのコメント', js: true do
    before do
      visit quest_path(quest.id)
    end

    scenario 'コメントを投稿すると非同期でページに反映される' do
      within page.all('.comment_form')[0] do
        fill_in 'comment_content', with: 'new_comment'
        click_button 'コメントする'
      end
      expect(page.find('p', text: 'new_comment', wait: 5)).to have_text 'new_comment'
    end

    scenario 'コメントを更新すると非同期でページに反映される' do
      page.find('.comment_edit_button').click
      within page.all('.comment_edit_form')[0] do
        fill_in 'comment_content', with: 'update_comment'
        click_button 'Save'
      end
      expect(page.find('p', text: 'update_comment', wait: 5)).to have_text 'update_comment'
    end

    scenario 'コメントに返信すると非同期でページに反映される' do
      page.find('.reply_button').click
      within page.all('.reply_form')[0] do
        fill_in 'comment_content', with: 'reply_comment'
        click_button 'Save'
      end
      expect(page.find('p', text: 'reply_comment', wait: 5)).to have_text 'reply_comment'
    end

    scenario 'コメントを削除すると非同期でページに反映される' do
      page.accept_confirm do
        page.find('.comment_delete_button').click
      end
      expect(page).not_to have_text 'positive_content'
    end
  end

  describe 'クエストの登録' do
    let!(:new_quest) { build(:quest) }

    scenario 'クエストを登録するとクエスト一覧ページに遷移する' do
      create_quest_with(new_quest.develop_id, new_quest.responsible, new_quest.title, new_quest.content)
      expect(current_path).to eq quests_path
    end

    scenario 'クエストを登録するとクエスト一覧ページにメッセージが表示される' do
      create_quest_with(new_quest.develop_id, new_quest.responsible, new_quest.title, new_quest.content)
      expect(page).to have_text 'クエストの登録に成功しました'
    end

    scenario 'クエストを登録するとクエスト一覧ページに登録したクエストが表示される' do
      create_quest_with(new_quest.develop_id, new_quest.responsible, new_quest.title, new_quest.content)
      expect(page).to have_content "Quest#{new_quest.develop_id} : #{new_quest.title}"
    end

    describe 'クエスト登録の失敗をテスト' do
      scenario '開発IDが入力されていないとエラーメッセージが表示される' do
        create_quest_with(nil, new_quest.responsible, new_quest.title, new_quest.content)
        expect(page).to have_text 'Questidを入力してください'
      end

      scenario '既に登録されている開発IDを入力するとエラーメッセージが表示される' do
        create_quest_with(quest.develop_id, new_quest.responsible, new_quest.title, new_quest.content)
        expect(page).to have_text 'Questidはすでに存在します'
      end

      scenario '担当者が入力されていないとエラーメッセージが表示される' do
        create_quest_with(new_quest.develop_id, nil, new_quest.title, new_quest.content)
        expect(page).to have_text '担当者を入力してください'
      end

      scenario 'タイトルが入力されていないとエラーメッセージが表示される' do
        create_quest_with(new_quest.develop_id, new_quest.responsible, nil, new_quest.content)
        expect(page).to have_text 'タイトルを入力してください'
      end
    end
  end

  describe 'クエストの更新' do
    scenario 'クエストを更新するとクエスト詳細ページに遷移する' do
      update_quest_with(quest.id, quest.develop_id, quest.responsible, 'update_quest_title', quest.content)
      expect(current_path).to eq quest_path(quest.id)
    end

    scenario 'クエストを更新するとクエスト詳細ページの内容が更新される' do
      update_quest_with(quest.id, quest.develop_id, quest.responsible, 'update_quest_title', quest.content)
      expect(page).to have_content "Quest#{quest.develop_id} : update_quest_title"
    end

    describe 'クエスト更新の失敗をテスト' do
      let!(:another_quest) { create(:quest) }

      scenario '開発IDが入力されていないとエラーメッセージが表示される' do
        update_quest_with(quest.id, nil, quest.responsible, quest.title, quest.content)
        expect(page).to have_text 'Questidを入力してください'
      end

      scenario '他のクエストで使用されている開発IDを入力するとエラーメッセージが表示される' do
        update_quest_with(quest.id, another_quest.develop_id, quest.responsible, quest.title, quest.content)
        expect(page).to have_text 'Questidはすでに存在します'
      end

      scenario '担当者が入力されていないとエラーメッセージが表示される' do
        update_quest_with(quest.id, quest.develop_id, nil, quest.title, quest.content)
        expect(page).to have_text '担当者を入力してください'
      end

      scenario 'タイトルが入力されていないとエラーメッセージが表示される' do
        update_quest_with(quest.id, quest.develop_id, quest.responsible, nil, quest.content)
        expect(page).to have_text 'タイトルを入力してください'
      end
    end
  end

  describe 'クエストの削除', js: true do
    let!(:delete_quest) { create(:quest) }

    before do
      visit edit_quest_path(delete_quest.id)
      page.accept_confirm do
        click_link 'クエストの削除'
      end
      page.find('a', text: "Quest#{quest.develop_id} : #{quest.title}")
    end

    scenario 'クエストを削除するとクエスト一覧ページに遷移する' do
      expect(current_path).to eq quests_path
    end

    scenario 'クエストを削除するとクエスト一覧ページにメッセージが表示される' do
      expect(page).to have_text 'クエストの削除が完了しました'
    end

    scenario 'クエストを削除するとクエスト一覧ページに表示されなくなる' do
      expect(page).not_to have_content "Quest#{delete_quest.develop_id} : #{delete_quest.title}"
    end
  end
end
