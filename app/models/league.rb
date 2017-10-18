class League < ApplicationRecord
  has_many :matchs, dependent: :destroy
  belongs_to :country
  belongs_to :continent
end
