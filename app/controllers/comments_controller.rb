class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: %i[update destroy]
  before_action :authenticate_owner, only: %i[update destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.save!
    @comments = Comment.where(quest_id: @comment.quest_id, opinion_type: @comment.opinion_type, parent_id: nil)
  end

  def update
    @comment.update!(comment_params)
  end

  def destroy
    @comment.destroy!
    @comments = Comment.where(quest_id: @comment.quest_id, opinion_type: @comment.opinion_type, parent_id: nil)
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params[:comment][:user_id] = current_user.id
    params.require(:comment).permit(:user_id, :quest_id, :content, :opinion_type, :parent_id)
  end

  def authenticate_owner
    redirect_to root_path if current_user.id != @comment.user_id
  end
end
