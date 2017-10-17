class Match < ApplicationRecord
  has_many :bets, dependent: :destroy
  belongs_to :team, foreign_key: :team1_id
  belongs_to :league
  belongs_to :stadium
end
