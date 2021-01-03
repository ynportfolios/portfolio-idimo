require 'rails_helper'

RSpec.describe 'Messages', type: :request do
  let(:user) { create(:user) }
  let(:user_a) { create(:user_a) }

  describe 'ログインしてメッセージの作成を行う' do
    before do
      user.confirm
      sign_in user
    end
    it '作成に成功する' do
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
      post messages_path(message: { content: 'test', room_id: room.id })
      expect(response).to redirect_to rooms_show_path(id: room.id)
    end
    it '作成に失敗する' do
      room = Room.create
      expect(room).to be_valid
      post messages_path(message: { content: 'test', room_id: room.id })
      expect(response).to redirect_to root_path
    end
  end
end
