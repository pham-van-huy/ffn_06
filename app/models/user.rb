class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  enum role: {user: false, admin: true}
  has_many :bets, dependent: :destroy
  has_many :new, dependent: :destroy
  has_one :social_account, dependent: :destroy, class_name: :Social_account

  mount_uploader :avatar, AvatarUploader
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true,
    length: {maximum: Settings.user.email_length}
  validates :password, presence: true, length: {minimum: Settings.user.password_length}, allow_nil: true
end
