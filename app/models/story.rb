class Story < ApplicationRecord
  validates :raw_title, presence: true
  validates :raw_body, presence: true
  
  belongs_to :user
#  belongs_to :admin, class_name: 'User'
#  belongs_to :poster, class_name: 'User'
#  belongs_to :author, class_name: 'User'
  
  has_many :comments, dependent: :destroy  # If story gets deleted, the depending comment also gets deleted
  has_many :story_likes, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  
  default_scope { order(created_at: :desc)}
  
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }
  #scope :published { where published: true}
  # =>  Story.published in controller do the above query
  # e.g. @ final_stories = Story.published
  #scope :unpublished {where published: false}
  # current_user.
  
end
