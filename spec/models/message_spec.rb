require 'rails_helper'

RSpec.describe Message, type: :model do
  it 'メッセージが200文字以内の場合、有効である' do
    user = FactoryBot.create(:user)
    room = Room.create
    message = Message.new(
      user_id: user.id,
      room_id: room.id,
      content: 'test'
    )
    expect(message).to be_valid
  end
  it 'メッセージがが201文字以上の場合、無効である' do
    user = FactoryBot.create(:user)
    room = Room.create
    message = Message.new(
      user_id: user.id,
      room_id: room.id,
      content: 'x' * 201
    )
    message.valid?
    expect(message.errors[:content]).to include('は200文字以内で入力してください')
  end
  it 'メッセージが0文字の場合、無効である' do
    user = FactoryBot.create(:user)
    room = Room.create
    message = Message.new(
      user_id: user.id,
      room_id: room.id,
      content: ''
    )
    message.valid?
    expect(message.errors[:content]).to include('は1文字以上で入力してください')
  end
  it 'メッセージがnilの場合、無効である' do
    user = FactoryBot.create(:user)
    room = Room.create
    message = Message.new(
      user_id: user.id,
      room_id: room.id,
      content: nil
    )
    message.valid?
    expect(message.errors[:content]).to include('を入力してください')
  end
end
