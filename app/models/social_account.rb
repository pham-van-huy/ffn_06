class Social_account < ApplicationRecord
  belongs_to :user
  validates :provider, length: {maximum: Settings.limit_provider}, presence: true
  validates :provider_id, length: {minimum: Settings.limit_provider}, presence: true
end
