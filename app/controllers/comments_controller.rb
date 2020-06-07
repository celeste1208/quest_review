class CommentsController < ApplicationController
  
  def new
    @comment = Comment.new
    @quest_id = params[:quest_id]
    @opinion_type = params[:opinion_type]
  end

  def create
    @comment = Comment.new(comment_params)
    # 成功・失敗のメッセージを入れる
    @comment.save
  end
  
  private
    def comment_params
      params[:comment][:user_id] = current_user.id
      params.require(:comment).permit(:user_id, :quest_id, :content, :opinion_type, :parent_id)
    end
end
