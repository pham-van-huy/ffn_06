class League < ApplicationRecord
  has_many :matchs, ->{order("start_time DESC")}, dependent: :destroy
  belongs_to :country
  belongs_to :continent
  scope :get_search, lambda{|key|
    joins(:country, :continent).where("countries.name REGEXP ? or continents.name REGEXP ?", key, key)
  }
  scope :desc, ->{order("created_at DESC")}
  mount_uploader :logo, LogoUploader
  validates :name, length: {maximum: Settings.limit_provider}, uniqueness: true, presence: true
  validates :time, :country_id, :continent_id, presence: true
end
