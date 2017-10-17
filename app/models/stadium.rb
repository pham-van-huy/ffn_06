class Stadium < ApplicationRecord
  belongs_to :country
  has_many :matchs, dependent: :destroy
end
