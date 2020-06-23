require 'rails_helper'

RSpec.describe Comment, type: :model do

  let!(:comment) { create(:comment) }

  it 'validation成功' do
    expect(comment).to be_valid
  end

  it 'user_idが存在しない場合はvalidation失敗' do
    comment = build(:comment, user_id: nil)
    expect(comment).not_to be_valid
  end

  it 'quest_idが存在しない場合はvalidation失敗' do
    comment = build(:comment, quest_id: nil)
    expect(comment).not_to be_valid
  end

  it 'contentが存在しない場合はvalidation失敗' do
    comment = build(:comment, content: nil)
    expect(comment).not_to be_valid
  end

  it 'opinion_typeが存在しない場合はvalidation失敗' do
    comment = build(:comment, opinion_type: nil)
    expect(comment).not_to be_valid
  end

end
