require 'rails_helper'

RSpec.describe 'Home', type: :request do
  describe '#index' do
    it 'リクエストが成功する' do
      get root_path
      expect(response).to be_successful
    end
  end
end
