class QuestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quest, only: %i[show edit update destroy]

  def index
    @quests = Quest.all.order(:develop_id)
  end

  def new
    @quest = Quest.new
  end

  def create
    @quest = Quest.new(quest_params)
    if @quest.save
      flash[:notice] = 'クエストの登録に成功しました'
      redirect_to quests_path
    else
      render 'new'
    end
  end

  def show
    @positive_comments = Comment.where(quest_id: @quest.id, opinion_type: 'positive', parent_id: nil)
                                .includes(:user, children: :user)
    @negative_comments = Comment.where(quest_id: @quest.id, opinion_type: 'negative', parent_id: nil)
                                .includes(:user, children: :user)
    @question_comments = Comment.where(quest_id: @quest.id, opinion_type: 'question', parent_id: nil)
                                .includes(:user, children: :user)
  end

  def edit
  end

  def update
    if @quest.update(quest_params)
      redirect_to quest_path(@quest.id)
    else
      render 'edit'
    end
  end

  def destroy
    @quest.destroy!
    flash[:notice] = 'クエストの削除が完了しました'
    redirect_to quests_path
  end

  private

  def set_quest
    @quest = Quest.find(params[:id])
  end

  def quest_params
    params.require(:quest).permit(:develop_id, :title, :content, :responsible)
  end
end
