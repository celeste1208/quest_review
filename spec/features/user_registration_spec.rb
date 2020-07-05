require 'rails_helper'

RSpec.feature 'UserRegistration', type: :feature do
  let(:user)        { build(:user) }
  let!(:exist_user) { create(:user, user_name: 'exits_user_name', email: 'exist@example.com') }

  describe 'ユーザー登録' do
    scenario 'ユーザー登録するとトップページに遷移する' do
      sign_up_with(user.user_name, user.email, user.password, user.password)
      expect(current_path).to eq root_path
    end

    scenario 'ユーザー登録するとログインする' do
      sign_up_with(user.user_name, user.email, user.password, user.password)
      expect(page).not_to have_content 'ログイン'
    end

    describe 'ユーザー登録失敗のテスト' do
      scenario 'user_nameが入力されていないとエラーメッセージが表示される' do
        sign_up_with(nil, user.email, user.password, user.password)
        expect(page).to have_text 'User nameを入力してください'
      end

      scenario '既に使用されているuser_nameが入力するとエラーメッセージが表示される' do
        sign_up_with(exist_user.user_name, user.email, user.password, user.password)
        expect(page).to have_text 'User nameはすでに存在します'
      end

      scenario 'emailが入力されていないとエラーメッセージが表示される' do
        sign_up_with(user.user_name, nil, user.password, user.password)
        expect(page).to have_text 'Eメールを入力してください'
      end

      scenario '既に使用されているemailを入力するとエラーメッセージが表示される' do
        sign_up_with(user.user_name, exist_user.email, user.password, user.password)
        expect(page).to have_text 'Eメールはすでに存在します'
      end

      scenario 'passwordが入力されていないとエラーメッセージが表示される' do
        sign_up_with(user.user_name, user.email, nil, user.password)
        expect(page).to have_text 'パスワードを入力してください'
      end

      scenario 'passwordが6文字以上でないとエラーメッセージが表示される' do
        sign_up_with(user.user_name, user.email, 'test', user.password)
        expect(page).to have_text 'パスワードは6文字以上で入力してください'
      end

      scenario 'passwordが確認用の入力と一致しないとエラーメッセージが表示される' do
        sign_up_with(user.user_name, user.email, user.password, nil)
        expect(page).to have_text 'パスワード（確認用）とパスワードの入力が一致しません'
      end
    end
  end
end
