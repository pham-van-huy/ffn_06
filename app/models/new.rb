class New < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :target
  default_scope{order("created_at DESC")}
end
