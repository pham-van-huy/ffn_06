class New < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :target, dependent: :destroy
  default_scope{order("created_at DESC")}
  validates :title, length: {maximum: Settings.limit_max_title}, presence: true
  validates :content, presence: true, length: {minimum: Settings.limit_min_content}
  mount_uploader :represent_image, NewimgUploader
end
