require 'rails_helper'

RSpec.describe Quest, type: :model do
  let!(:quest) { create(:quest) }

  it 'validation成功' do
    expect(quest).to be_valid
  end

  it 'develop_idが存在しない場合はvalidation失敗' do
    quest = build(:quest, develop_id: nil)
    expect(quest).not_to be_valid
  end

  it 'develop_idがユニークでない場合はvalidation失敗' do
    quest2 = build(:quest, develop_id: quest.develop_id)
    expect(quest2).not_to be_valid
  end

  it 'titleが存在しない場合はvalidation失敗' do
    quest = build(:quest, title: nil)
    expect(quest).not_to be_valid
  end

  it 'responsibleが存在しない場合はvalidation失敗' do
    quest = build(:quest, responsible: nil)
    expect(quest).not_to be_valid
  end
end
