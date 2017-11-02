class Match < ApplicationRecord
  has_many :bets, dependent: :destroy
  belongs_to :teams_col_one, foreign_key: :team1_id, class_name: :Team
  belongs_to :teams_col_two, foreign_key: :team2_id, class_name: :Team
  belongs_to :league
  belongs_to :stadium
  scope :desc, ->{order "start_time DESC"}
  scope :team_limit, ->{limit Settings.limit_bet}
  scope :matched, ->{where("end_time < ?", DateTime.now)}
  scope :vs, ->(arr_id, id){where.not(id: id).where("team1_id IN (?) AND team2_id IN (?)", arr_id, arr_id)}

  def get_team id
    Team.find_by_id id
  end
end
