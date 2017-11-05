class Bet < ApplicationRecord
  belongs_to :user
  belongs_to :match
  scope :bet_by_match, ->(user_id){where("user_id = ?", user_id)}
  scope :desc, ->{order "created_at DESC"}
  scope :get_beted, ->{where("result = true")}
end
