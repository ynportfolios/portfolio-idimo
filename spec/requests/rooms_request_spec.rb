require 'rails_helper'

RSpec.describe 'Rooms', type: :request do
  let(:user) { create(:user) }
  let(:user_a) { create(:user_a) }

  describe 'ログインしてルームの作成を行う' do
    before do
      user.confirm
      sign_in user
    end
    it '作成に成功する' do
      post rooms_path(entry: { user_id: user_a.id })
      room = Room.order(id: :desc).last
      expect(response).to redirect_to rooms_show_path(id: room.id)
    end
  end
end

RSpec.describe 'Rooms', type: :request do
  let(:user) { create(:user) }
  let(:user_a) { create(:user_a) }

  describe 'ログインしてshowページを取得する' do
    before do
      user.confirm
      sign_in user
    end
    it '取得に成功する' do
      room = Room.create
      expect(room).to be_valid
      entry = Entry.create(
        user_id: user.id,
        room_id: room.id
      )
      expect(entry).to be_valid
      entry_a = Entry.create(
        user_id: user_a.id,
        room_id: room.id
      )
      expect(entry_a).to be_valid
      get rooms_show_path(id: room.id)
      expect(response).to have_http_status(:success)
    end
    it '取得に失敗する' do
      room = Room.create
      expect(room).to be_valid
      get rooms_show_path(id: room.id)
      expect(response).to redirect_to root_path
    end
  end
end

RSpec.describe 'Rooms', type: :request do
  let(:user) { create(:user) }
  let(:user_a) { create(:user_a) }

  describe 'ログインしてindexページを取得する' do
    before do
      user.confirm
      sign_in user
    end
    it '取得に成功する（Entryが存在する場合）' do
      room = Room.create
      expect(room).to be_valid
      entry = Entry.create(
        user_id: user.id,
        room_id: room.id
      )
      expect(entry).to be_valid
      entry_a = Entry.create(
        user_id: user_a.id,
        room_id: room.id
      )
      expect(entry_a).to be_valid
      get rooms_path
      expect(response).to have_http_status(:success)
    end
    it '取得に成功する（Entryが存在しない場合）' do
      get rooms_path
      expect(response).to have_http_status(:success)
    end
  end
end
