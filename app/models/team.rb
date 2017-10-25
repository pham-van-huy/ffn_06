class Team < ApplicationRecord
  attr_accessor :score
  has_many :players, dependent: :destroy
  has_many :matchs_one, dependent: :destroy, foreign_key: :team1_id, class_name: :Match
  has_many :matchs_two, dependent: :destroy, foreign_key: :team2_id, class_name: :Match
  belongs_to :country
  belongs_to :country
end
