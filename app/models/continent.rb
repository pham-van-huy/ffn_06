class Continent < ApplicationRecord
  has_many :countries, dependent: :destroy
  has_many :teams, dependent: :destroy
end
