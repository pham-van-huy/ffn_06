class User < ApplicationRecord
  has_many :bets, dependent: :destroy
  has_many :new, dependent: :destroy
  has_secure_password
end
