class Country < ApplicationRecord
  belongs_to :continent
  has_many :players, dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :leagues, dependent: :destroy
  has_many :stadia, dependent: :destroy
  scope :get_by_continent,->continent_id{where("continent_id = ?", continent_id).select(:id, :name)}
end
