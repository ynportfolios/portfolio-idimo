require 'rails_helper'

RSpec.describe User, type: :model do
  it 'Eメール、ユーザ名、好きな動物、性別、生年月日、パスワードがある場合、有効である' do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it 'Eメールがない場合、無効である' do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include('を入力してください')
  end

  it '重複したEメールの場合、無効である' do
    user_a = FactoryBot.create(:user)
    user_b = FactoryBot.build(:user)
    user_b.valid?
    expect(user_a).to be_valid
    expect(user_b.errors[:email]).to include('はすでに存在します')
  end

  it 'ユーザ名がない場合、無効である' do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include('を入力してください')
    expect(user.errors[:name]).to include('は1文字以上で入力してください')
  end

  it 'ユーザ名が16文字以上の場合、無効である' do
    user = FactoryBot.build(:user, name: 'x' * 16)
    user.valid?
    expect(user.errors[:name]).to include('は15文字以内で入力してください')
  end

  it '好きな動物がない場合、無効である' do
    user = FactoryBot.build(:user, animal: nil)
    user.valid?
    expect(user.errors[:animal]).to include('を入力してください')
    expect(user.errors[:animal]).to include('は1文字以上で入力してください')
    expect(user.errors[:animal]).to include('は不正な値です')
  end

  it '好きな動物が31文字以上の場合、無効である' do
    user = FactoryBot.build(:user, animal: 'x' * 31)
    user.valid?
    expect(user.errors[:animal]).to include('は30文字以内で入力してください')
  end

  it '好きな動物がひらがなの場合、無効である' do
    user = FactoryBot.build(:user, animal: 'あ')
    user.valid?
    expect(user.errors[:animal]).to include('は不正な値です')
  end

  it '好きな動物が漢字の場合、無効である' do
    user = FactoryBot.build(:user, animal: '阿')
    user.valid?
    expect(user.errors[:animal]).to include('は不正な値です')
  end

  it '好きな動物が英字の場合、無効である' do
    user = FactoryBot.build(:user, animal: 'a')
    user.valid?
    expect(user.errors[:animal]).to include('は不正な値です')
  end

  it '好きな動物が数字の場合、無効である' do
    user = FactoryBot.build(:user, animal: '1')
    user.valid?
    expect(user.errors[:animal]).to include('は不正な値です')
  end

  it '性別がない場合、無効である' do
    user = FactoryBot.build(:user, sex: nil)
    user.valid?
    expect(user.errors[:sex]).to include('を入力してください')
  end

  it '生年月日がない場合、無効である' do
    user = FactoryBot.build(:user, birth_date: nil)
    user.valid?
    expect(user.errors[:birth_date]).to include('を入力してください')
  end

  it 'パスワードがない場合、無効である' do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include('を入力してください')
  end

  it '自己紹介が201文字以上の場合、無効である' do
    user = FactoryBot.build(:user, profile: 'x' * 201)
    user.valid?
    expect(user.errors[:profile]).to include('は200文字以内で入力してください')
  end

  it '自分以外のユーザを処理した場合、フォローを行う' do
    user = FactoryBot.create(:user)
    user_a = FactoryBot.create(:user_a)
    user.follow(user_a)
    expect(user.followings.include?(user_a)).to be true
  end

  it '自分自身のユーザを処理した場合、フォローを行わない' do
    user = FactoryBot.create(:user)
    user.follow(user)
    expect(user.followings.include?(user)).to be false
  end

  it 'フォローしている場合、フォロー解除を行う' do
    user = FactoryBot.create(:user)
    user_a = FactoryBot.create(:user_a)
    user.follow(user_a)
    expect(user.followings.include?(user_a)).to be true
    user.unfollow(user_a)
    expect(user.followings.include?(user_a)).to be false
  end

  it 'フォローしている場合、trueを返す' do
    user = FactoryBot.create(:user)
    user_a = FactoryBot.create(:user_a)
    user.follow(user_a)
    expect(user.following?(user_a)).to be true
  end

  it 'フォローしていない場合、falseを返す' do
    user = FactoryBot.create(:user)
    user_a = FactoryBot.create(:user_a)
    expect(user.following?(user_a)).to be false
  end

  it 'ゲストユーザを作成する' do
    user = User.guest
    expect(user).to be_valid
    expect(user.email).to eq('guest@example.com')
  end
end
