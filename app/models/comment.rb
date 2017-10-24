class Comment < ApplicationRecord
  belongs_to :target, polymorphic: true
  belongs_to :user
  scope :desc, ->{order("created_at DESC")}
end
