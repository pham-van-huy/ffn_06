class League < ApplicationRecord
  has_many :matchs, ->{order("start_time DESC")}, dependent: :destroy
  belongs_to :country
  belongs_to :continent
  scope :get_search, lambda{|key|
    joins(:country, :continent).where("countries.name REGEXP ? or continents.name REGEXP ?", key, key)
  }
  scope :desc, ->{order("created_at DESC")}
end
