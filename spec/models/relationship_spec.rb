require 'rails_helper'

RSpec.describe Relationship, type: :model do
  it 'ユーザID、フォローIDがある場合、有効である' do
    user = FactoryBot.create(:user)
    user_a = FactoryBot.create(:user_a)
    relationship = Relationship.new(
      user_id: user.id,
      follow_id: user_a.id
    )
    expect(relationship).to be_valid
  end
  it 'フォローIDがない場合、無効である' do
    user = FactoryBot.create(:user)
    relationship = Relationship.new(
      user_id: user.id,
      follow_id: nil
    )
    relationship.valid?
    expect(relationship.errors[:follow_id]).to include('を入力してください')
  end
  it 'ユーザIDがない場合、無効である' do
    user_a = FactoryBot.create(:user_a)
    relationship = Relationship.new(
      user_id: nil,
      follow_id: user_a.id
    )
    relationship.valid?
    expect(relationship.errors[:user_id]).to include('を入力してください')
  end
end
