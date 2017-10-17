class Team < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :matchs, dependent: :destroy, foreign_key: :team1_id
  belongs_to :country
  belongs_to :country
end
