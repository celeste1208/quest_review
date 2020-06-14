class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  
  def new
    @comment = Comment.new(
      quest_id: params[:quest_id], opinion_type: params[:opinion_type], parent_id: params[:parent_id])
  end

  def create
    @comment = Comment.new(comment_params)
    # 成功・失敗のメッセージを入れる
    @comment.save
    @comments = Comment.where(quest_id: @comment.quest_id, opinion_type: @comment.opinion_type, parent_id: nil)
  end
  
  def edit
  end
  
  def update
    # 成功・失敗のメッセージを入れる
    @comment.update(comment_params)
  end
  
  def destroy
    @comment.destroy
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
end
