class Stadium < ApplicationRecord
  belongs_to :country
  has_many :matchs, dependent: :destroy
  scope :get_by_country, ->country_id{where("country_id = ?", country_id).select(:id, :name)}
end
