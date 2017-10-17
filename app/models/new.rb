class New < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :target
end
