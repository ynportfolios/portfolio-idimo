require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  describe 'ログインせずにindexページを取得する' do
    it '取得に成功する' do
      get root_path
    end
  end
end

RSpec.describe 'Homes', type: :request do
  let(:user) { create(:user) }

  describe 'ログインしてindexページを取得する' do
    before do
      user.confirm
      sign_in user
    end
    it '取得に成功する' do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end
end

RSpec.describe 'Homes', type: :request do
  let(:user) { create(:user) }

  describe 'ログインしてshowページを取得する' do
    before do
      user.confirm
      sign_in user
    end
    it '取得に成功する' do
      get homes_show_path
      expect(response).to have_http_status(:success)
    end
  end
end

RSpec.describe 'Homes', type: :request do
  let(:user) { create(:user) }

  describe 'ログインしてcheckページを取得する' do
    before do
      user.confirm
      sign_in user
    end
    it '取得に成功する（フォロー中）' do
      get homes_check_path(status: 'follow')
      expect(response).to have_http_status(:success)
    end
    it '取得に成功する（フォロワー）' do
      get homes_check_path(status: 'follower')
      expect(response).to have_http_status(:success)
    end
  end
end
