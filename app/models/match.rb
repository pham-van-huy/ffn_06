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
  validates :team1_id, :team2_id, :league_id, :stadium_id, :start_time, :end_time, presence: true

  def get_team id
    Team.find_by_id id
  end
  def self.update_match_bet match
    bets = match.bets
    bets.each do |bet|
      if bet.team1_goal == match.team1_goal && bet.team2_goal == match.team2_goal
        bet.update_attribute(:result, true)
        bet.user.update_attribute(:coin, 2*bet.coin + bet.user.coin)
      else
        bet.update_attribute(:result, false)
      end
    end
  end
end
