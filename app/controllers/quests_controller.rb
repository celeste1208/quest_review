class QuestsController < ApplicationController
  before_action :set_quest, only: [:show, :edit, :update]

  def index
    @quests = Quest.all.order(:develop_id)
  end
  
  def new
    @quest = Quest.new
  end
  
  def show
    @positive_comments = Comment.where(quest_id: @quest.id, opinion_type: 'positive', parent_id: nil)
    @negative_comments = Comment.where(quest_id: @quest.id, opinion_type: 'negative', parent_id: nil)
    @question_comments = Comment.where(quest_id: @quest.id, opinion_type: 'question', parent_id: nil)
  end
  
  def edit
  end
  
  def create
    @quest = Quest.new(quest_params)
    # 成功・失敗のメッセージを入れる
    if @quest.save
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  def update
    # 成功・失敗のメッセージを入れる
    @quest.update(quest_params)
    render edit_quest_path(@quest.id)
  end
  
  private
    def set_quest
      @quest = Quest.find(params[:id])
    end
  
    def quest_params
      params.require(:quest).permit(:develop_id, :title, :content, :responsible)
    end
end
