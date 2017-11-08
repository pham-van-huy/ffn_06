class Social_account < ApplicationRecord
  belongs_to :user
  validates :provider, presence: true
  validates :provider_id, presence: true
end
