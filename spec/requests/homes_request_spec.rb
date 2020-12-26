require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  describe 'indexページ' do
    it '表示に成功する' do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end
end

RSpec.describe 'Homes', type: :request do
  let(:user) { create(:user) }

  describe 'showページ' do
    before do
      user.confirm
      sign_in user
    end
    it '表示に成功する' do
      get homes_show_path
      expect(response).to have_http_status(:success)
    end
  end
end
