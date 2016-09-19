class Story < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  
  belongs_to :user
  has_many :comments, dependent: :destroy  # If story gets deleted, the depending comment also gets deleted
  has_many :story_likes, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  
  default_scope { order(created_at: :desc)}
  
  #scope :published { where published: true}
  # =>  Story.published in controller do the above query
  # e.g. @ final_stories = Story.published
  #scope :unpublished {where published: false}
  # current_user.
  
end
