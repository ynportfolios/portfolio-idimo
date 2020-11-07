class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 20201107 ユーザ情報の追加 start
  # 性別の関連付け
  enum sex: { man: 0, woman: 1, other: 2, no_answer: 3 }

  validates :name, presence: true, length: { minimum: 1, maximum: 15 }
  validates :sex, presence: true
  validates :birth_date, presence: true
  validates :animal, presence: true, length: { minimum: 1, maximum: 30 }, format: { with: /\A([ァ-ン]|ー)+\z/ }
  validates :profile, length: { maximum: 200 }
  # 20201107 ユーザ情報の追加 end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'ゲストユーザ'
      user.sex = 3
      user.birth_date = Date.new(1989, 1, 1)
      user.animal = 'イヌ'
    end
  end
end
