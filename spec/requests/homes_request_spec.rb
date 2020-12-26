require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  describe 'ログインせずにindexページを取得する' do
    it '取得に成功し、正しいリンクのみ存在する' do
      get root_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include '<a class="navbar-brand" href="/">idimo</a>'
      expect(response.body).to include '<a class="nav-link" href="/users/sign_up">新規登録</a>'
      expect(response.body).to include '<a class="nav-link" href="/users/sign_in">ログイン</a>'
      expect(response.body).to include '<a class="nav-link" rel="nofollow" data-method="post" href="/users/guest_sign_in">ゲストログイン（閲覧用）</a>'
      expect(response.body).to_not include '<a class="nav-link" href="/homes/show">ユーザ検索</a>'
      expect(response.body).to_not include '<a class="nav-link" href="/users/show?id='
      expect(response.body).to_not include '">マイプロフィール</a>'
      expect(response.body).to_not include '<a class="nav-link" href="/users/edit">アカウント編集</a>'
      expect(response.body).to_not include '<a class="nav-link" href="/homes/check?status=follow">フォロー中</a>'
      expect(response.body).to_not include '<a class="nav-link" href="/homes/check?status=follower">フォロワー</a>'
      expect(response.body).to_not include '<a class="nav-link" rel="nofollow" data-method="delete" href="/users/sign_out">ログアウト</a>'
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
    it '取得に成功し、正しいリンクのみ存在する' do
      get root_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include '<a class="navbar-brand" href="/">idimo</a>'
      expect(response.body).to include '<a class="nav-link" href="/homes/show">ユーザ検索</a>'
      expect(response.body).to include '<a class="nav-link" href="/users/show?id=' + user.id.to_s + '">マイプロフィール</a>'
      expect(response.body).to include '<a class="nav-link" href="/users/edit">アカウント編集</a>'
      expect(response.body).to include '<a class="nav-link" href="/homes/check?status=follow">フォロー中</a>'
      expect(response.body).to include '<a class="nav-link" href="/homes/check?status=follower">フォロワー</a>'
      expect(response.body).to include '<a class="nav-link" rel="nofollow" data-method="delete" href="/users/sign_out">ログアウト</a>'
      expect(response.body).to_not include '<a class="nav-link" href="/users/sign_up">新規登録</a>'
      expect(response.body).to_not include '<a class="nav-link" href="/users/sign_in">ログイン</a>'
      expect(response.body).to_not include '<a class="nav-link" rel="nofollow" data-method="post" href="/users/guest_sign_in">ゲストログイン（閲覧用）</a>'
    end
  end
end

RSpec.describe 'Homes', type: :request do
  describe 'ログインせずにshowページを取得する' do
    it '表示に成功する' do
      get homes_show_path
      expect(response).to_not have_http_status(:success)
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
    it '表示に成功する' do
      get homes_show_path
      expect(response).to have_http_status(:success)
    end
  end
end
