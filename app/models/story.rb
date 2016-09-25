class Story < ApplicationRecord
  validates :raw_title, presence: true
  validates :raw_body, presence: true
  
  validates :final_title, presence: true, :if => Proc.new { user.admin? }
  validates :final_body, presence: true, :if => Proc.new { user.admin? }
  
  belongs_to :user
  
  has_many :comments, dependent: :destroy  # If story gets deleted, the depending comment also gets deleted
  has_many :story_likes, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  
  default_scope { order(created_at: :desc)}
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }
  
end