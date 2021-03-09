class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  # 20201107 ユーザ情報の追加 start
  # 性別の関連付け
  enum sex: { man: 0, woman: 1, other: 2, no_answer: 3 }

  validates :name, presence: true, length: { minimum: 1, maximum: 15 }
  validates :sex, presence: true
  validates :birth_date, presence: true
  validates :animal, presence: true, length: { minimum: 1, maximum: 30 }, format: { with: /\A([ァ-ン]|ー)+\z/ }
  validates :profile, length: { maximum: 200 }
  # 20201107 ユーザ情報の追加 end

  # 20201116 フォロー機能の実装 start
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow, dependent: :destroy
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :user, dependent: :destroy

  # 20201123 ダイレクトメッセージの実装 start
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  # 20201123 ダイレクトメッセージの実装 end

  # 20201129 プロフィール写真の実装
  mount_uploader :image, ImageUploader

  def follow(other_user)
    relationships.find_or_create_by(follow_id: other_user.id) unless self == other_user
  end

  def unfollow(other_user)
    relationship = relationships.find_by(follow_id: other_user.id)
    relationship.destroy unless relationship&.nil?
  end

  def following?(other_user)
    followings.include?(other_user)
  end
  # 20201116 フォロー機能の実装 end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.confirmed_at = Time.now
      user.name = 'ゲストユーザ'
      user.sex = 3
      user.birth_date = Date.new(1989, 1, 1)
      user.animal = 'イヌ'
      user.profile = 'はじめまして。趣味は音楽鑑賞です。よろしくお願いします！'
    end
  end
end
