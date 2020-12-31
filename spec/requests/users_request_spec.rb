require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user) }
  let(:user_a) { create(:user_a) }

  describe 'ログインしてshowページを取得する' do
    before do
      user.confirm
      user_a.confirm
      sign_in user
    end
    it 'ユーザが自身のshowページの取得に成功する' do
      get users_show_path(id: user.id)
      expect(response).to have_http_status(:success)
    end
    it 'ユーザが他者のshowページの取得に成功する' do
      # ダイレクトメッセージ機能で使用するroomとentryをインスタンス化する
      get users_show_path(id: user_a.id)
      expect(response).to have_http_status(:success)
    end
    it 'ユーザが他者のshowページの取得に成功する' do
      # ダイレクトメッセージ機能で使用するroomを取得する
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
      get users_show_path(id: user_a.id)
      expect(response).to have_http_status(:success)
    end
  end
end
