class Comment < ApplicationRecord
  belongs_to :target, polymorphic: true
  belongs_to :user
  default_scope{order("created_at DESC")}
end
