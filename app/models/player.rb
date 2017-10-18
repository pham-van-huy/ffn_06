class Player < ApplicationRecord
  has_many :matchs, dependent: :destroy
  belongs_to :team
  belongs_to :country
end
