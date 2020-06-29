require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let(:user)                 { create(:user) }
  let!(:quest)               { create(:quest) }
  let!(:comment)             { create(:comment, :positive, quest: quest, user: user) }
  let(:another_user_comment) { create(:comment) }

  describe '#create' do
    let(:new_comment_params) { { comment: attributes_for(:comment, :positive, quest_id: quest.id) } }

    before do
      sign_in user
    end

    it 'コメントが作成される' do
      expect { post comments_path, params: new_comment_params, xhr: true }.to change(Comment, :count).by(1)
    end

    context 'ログインしていないユーザーの場合' do
      before do
        sign_out user
        post comments_path
      end

      it 'ログインページにリダイレクトする' do
        expect(response).to redirect_to user_session_path
      end
    end
  end

  describe '#update' do
    let(:update_comment_params) do
      { comment: attributes_for(
        :comment, :positive, content: 'update_comment_content'
      ) }
    end

    before do
      sign_in user
      patch comment_path(comment.id), params: update_comment_params, xhr: true
    end

    it 'コメントが更新される' do
      comment.reload
      expect(comment.content).to eq 'update_comment_content'
    end

    context '別のユーザーのコメントを更新しようとした場合' do
      before do
        patch comment_path(another_user_comment.id)
      end

      it 'トップページにリダイレクトする' do
        expect(response).to redirect_to root_path
      end
    end

    context 'ログインしていないユーザーの場合' do
      before do
        sign_out user
        patch comment_path(comment.id)
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

    it 'コメントが削除される' do
      expect { delete comment_path(comment.id), xhr: true }.to change(Comment, :count).by(-1)
    end

    context '別のユーザーのコメントを削除しようとした場合' do
      before do
        delete comment_path(another_user_comment.id)
      end

      it 'トップページにリダイレクトする' do
        expect(response).to redirect_to root_path
      end
    end

    context 'ログインしていないユーザーの場合' do
      before do
        sign_out user
        delete comment_path(comment.id)
      end

      it 'ログインページにリダイレクトする' do
        expect(response).to redirect_to user_session_path
      end
    end
  end
end
