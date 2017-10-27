class League < ApplicationRecord
  has_many :matchs, dependent: :destroy
  belongs_to :country
  belongs_to :continent
  scope :get_search, ->(key) {
    joins(:country, :continent).where("countries.name REGEXP ? or continents.name REGEXP ?", key, key)
  }
end
