require 'rails_helper'

RSpec.feature 'UserAuthentication', type: :feature do
  let!(:user) { create(:user) }

  describe 'ログイン' do
    scenario 'ログインするとトップページに遷移する' do
      log_in_with(user.email, user.password)
      expect(current_path).to eq root_path
    end

    scenario 'ログインするとトップページにログインリンクが表示されなくなる' do
      log_in_with(user.email, user.password)
      expect(page).not_to have_content 'ログイン'
    end

    describe 'ログイン失敗のテスト' do
      context 'Emailの入力が不正な場合' do
        before do
          log_in_with(nil, user.password)
        end

        scenario 'ログインに失敗する' do
          expect(current_path).to eq new_user_session_path
        end

        scenario 'エラーメッセージが表示される' do
          expect(page).to have_text 'Eメールまたはパスワードが違います。'
        end
      end

      context 'Passwordの入力が不正な場合' do
        before do
          log_in_with(user.email, nil)
        end

        scenario 'ログインに失敗する' do
          expect(current_path).to eq new_user_session_path
        end

        scenario 'エラーメッセージが表示される' do
          expect(page).to have_text 'Eメールまたはパスワードが違います。'
        end
      end
    end
  end

  describe 'ログアウト' do
    before do
      sign_in user
      visit user_path(user.id)
      click_link 'ログアウト'
    end

    scenario 'ログアウトするとトップページに遷移する' do
      expect(current_path).to eq root_path
    end

    scenario 'ログアウトするとトップページにログインリンクが表示される' do
      expect(page).to have_content 'ログイン'
    end
  end
end
