class Match < ApplicationRecord
  has_many :bets, dependent: :destroy
  belongs_to :teams_col_one, foreign_key: :team1_id, class_name: :Team
  belongs_to :teams_col_two, foreign_key: :team2_id, class_name: :Team
  belongs_to :league
  belongs_to :stadium
end
