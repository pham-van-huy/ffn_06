class User < ApplicationRecord
  has_many :bets, dependent: :destroy
  has_many :new, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.user.name_length}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.user.email_length},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: Settings.user.password_length}, allow_nil: true
end
