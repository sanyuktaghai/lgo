class Story < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  
  belongs_to :user
  has_many :comments, dependent: :destroy  # If article gets deleted, the depending comment also gets deleted
  
  default_scope { order(created_at: :desc)}
  
end
