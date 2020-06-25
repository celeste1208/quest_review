require 'rails_helper'

RSpec.describe "Quests", type: :request do
  let(:user)   { create(:user) }
  let!(:quest) { create(:quest) }

  describe "#index" do
    before do
      sign_in user
      get quests_path
    end

    it 'リクエストが成功する' do
      expect(response).to be_successful
    end

    it 'クエストが表示される' do
      expect(response.body).to include "Quest#{quest.develop_id} : #{quest.title}"
    end

    context 'ログインしていないユーザーの場合' do
      before do
        sign_out user
        get quests_path
      end

      it 'ログインページにリダイレクトする' do
        expect(response).to redirect_to user_session_path
      end
    end
  end

  describe '#new' do
    before do
      sign_in user
      get new_quest_path
    end

    it 'リクエストが成功する' do
      expect(response).to be_successful
    end

    it 'クエスト登録フォームが表示される' do
      expect(response.body).to have_tag('div', with: { class: 'quest_form' })
    end

    context 'ログインしていないユーザーの場合' do
      before do
        sign_out user
        get new_quest_path
      end

      it 'ログインページにリダイレクトする' do
        expect(response).to redirect_to user_session_path
      end
    end
  end

  describe '#create' do
    let(:new_quest_params) { { quest: attributes_for(:quest) } }

    before do
      sign_in user
    end

    it 'クエストが作成される' do
      expect{ post quests_path, params: new_quest_params }.to change(Quest, :count).by(1)
    end

    it 'クエスト一覧ページにリダイレクトする' do
      post quests_path, params: new_quest_params
      expect(response).to redirect_to quests_path
    end

    context 'クエストの作成に失敗した場合' do
      let(:new_quest_invalid_params) { { quest: attributes_for(:quest, develop_id: nil) } }

      before do
        post quests_path, params: new_quest_invalid_params
      end

      it 'Validationエラーメッセージが表示される' do
        expect(response.body).to have_tag('h2', text: /^(?=.*Error).*$/)
      end

      it 'クエスト登録フォームが表示される' do
        expect(response.body).to have_tag('div', with: { class: 'quest_form' })
      end
    end

    context 'ログインしていないユーザーの場合' do
      before do
        sign_out user
        post quests_path
      end

      it 'ログインページにリダイレクトする' do
        expect(response).to redirect_to user_session_path
      end
    end
  end

  describe '#show' do
    let!(:positive_comment) { create(:comment, :positive, quest: quest) }
    let!(:negative_comment) { create(:comment, :negative, quest: quest) }
    let!(:question_comment) { create(:comment, :question, quest: quest) }

    before do
      sign_in user
      get quest_path(quest.id)
    end

    it 'リクエストが成功する' do
      expect(response).to be_successful
    end

    it 'クエストが表示される' do
      expect(response.body).to include "Quest#{quest.develop_id} : #{quest.title}"
    end

    it '良かった点のコメントが表示される' do
      expect(response.body).to include positive_comment.content
    end

    it '改善点のコメントが表示される' do
      expect(response.body).to include negative_comment.content
    end

    it '質問のコメントが表示される' do
      expect(response.body).to include question_comment.content
    end

    context 'ログインしていないユーザーの場合' do
      before do
        sign_out user
        get quest_path(quest.id)
      end

      it 'ログインページにリダイレクトする' do
        expect(response).to redirect_to user_session_path
      end
    end
  end

  describe '#edit' do
    before do
      sign_in user
      get edit_quest_path(quest.id)
    end

    it 'リクエストが成功する' do
      expect(response).to be_successful
    end

    it 'クエスト登録フォームが表示される' do
      expect(response.body).to have_tag('div', with: { class: 'quest_form' })
    end

    it 'クエストページに戻るリンクが表示される' do
      expect(response.body).to have_tag('a', with: { href: quest_path(quest.id) } )
    end

    context 'ログインしていないユーザーの場合' do
      before do
        sign_out user
        get edit_quest_path(quest.id)
      end

      it 'ログインページにリダイレクトする' do
        expect(response).to redirect_to user_session_path
      end
    end
  end

  describe '#update' do
    let(:update_quest_params) { { quest: attributes_for(:quest, title: 'update_quest_title') } }

    before do
      sign_in user
      patch quest_path(quest.id), params: update_quest_params
    end

    it 'クエストが更新される' do
      quest.reload
      expect(quest.title).to eq 'update_quest_title'
    end

    it 'クエストページにリダイレクトする' do
      expect(response).to redirect_to quest_path(quest.id)
    end

    context 'クエストの更新に失敗した場合' do
      let(:update_quest_invalid_params) { { quest: attributes_for(:quest, develop_id: nil) } }

      before do
        patch quest_path(quest.id), params: update_quest_invalid_params
      end

      it 'Validationエラーメッセージが表示される' do
        expect(response.body).to have_tag('h2', text: /^(?=.*Error).*$/)
      end

      it 'クエスト登録フォームが表示される' do
        expect(response.body).to have_tag('div', with: { class: 'quest_form' })
      end

      it 'クエストページに戻るリンクが表示される' do
        expect(response.body).to have_tag('a', with: { href: quest_path(quest.id) } )
      end
    end

    context 'ログインしていないユーザーの場合' do
      before do
        sign_out user
        patch quest_path(quest.id)
      end

      it 'ログインページにリダイレクトする' do
        expect(response).to redirect_to user_session_path
      end
    end
  end

  describe '#destroy' do
    before do
      sign_in user
    end

    it 'クエストが削除される' do
      expect{ delete quest_path(quest.id) }.to change(Quest, :count).by(-1)
    end

    it 'クエスト一覧ページにリダイレクトする' do
      delete quest_path(quest.id)
      expect(response).to redirect_to quests_path
    end

    context 'ログインしていないユーザーの場合' do
      before do
        sign_out user
        delete quest_path(quest.id)
      end

      it 'ログインページにリダイレクトする' do
        expect(response).to redirect_to user_session_path
      end
    end
  end
end
