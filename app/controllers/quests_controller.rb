class QuestsController < ApplicationController
  before_action :set_quest, only: [:show, :edit, :update, :destroy]

  def index
    @quests = Quest.all.order(:develop_id)
  end
  
  def new
    @quest = Quest.new
  end
  
  def create
    @quest = Quest.new(quest_params)
    # 成功・失敗のメッセージを入れる
    if @quest.save
      redirect_to quests_path
    else
      render 'new'
    end
  end
  
  def show
    @positive_comments = Comment.where(quest_id: @quest.id, opinion_type: 'positive', parent_id: nil).
      includes(:user, children: :user)
    @negative_comments = Comment.where(quest_id: @quest.id, opinion_type: 'negative', parent_id: nil).
      includes(:user, children: :user)
    @question_comments = Comment.where(quest_id: @quest.id, opinion_type: 'question', parent_id: nil).
      includes(:user, children: :user)
  end
  
  def edit
  end
  
  def update
    # 成功・失敗のメッセージを入れる
    @quest.update(quest_params)
    render edit_quest_path(@quest.id)
  end
  
  def destroy
    if @quest.destroy
      flash[:notice] = "Sccess to delete quest"
      redirect_to quests_path
    else 
      flash[:alert] = "Fail to delete quest"
      redirect_to edit_quest_path(@quest.id)
    end
  end
  
  private
    def set_quest
      @quest = Quest.find(params[:id])
    end
  
    def quest_params
      params.require(:quest).permit(:develop_id, :title, :content, :responsible)
    end
end
