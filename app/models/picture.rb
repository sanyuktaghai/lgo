class Picture < ApplicationRecord
  belongs_to :story
  
  has_attached_file :image, styles: {
    medium: '300x300>'
  }
  
#  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_attachment :image, :content_type => { content_type: ["image/jpeg", "image/jpg", "image/gif", "image/png"] }, :size => { in: 0..8.megabytes }
  
  attr_accessor :validate_story_image
  
  def validate_story_image?
    validate_story_image == 'true' || validate_story_image == true
  end
  
  validates_attachment_presence :image, if: :validate_story_image?
end