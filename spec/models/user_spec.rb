require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  it 'validation成功' do
    expect(user).to be_valid
  end

  it 'user_nameが存在しない場合はvalidation失敗' do
    user = build(:user, user_name: nil)
    expect(user).not_to be_valid
  end

  it 'user_nameがユニークでない場合はvalidation失敗' do
    user2 = build(:user, user_name: user.user_name)
    expect(user2).not_to be_valid
  end

  it 'emailが存在しない場合はvalidation失敗' do
    user = build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it 'emailがユニークでない場合はvalidation失敗' do
    user2 = build(:user, email: user.email)
    expect(user2).not_to be_valid
  end

  it 'paswordが存在しない場合はvalidation失敗' do
    user = build(:user, password: nil)
    expect(user).not_to be_valid
  end
end
