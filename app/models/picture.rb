class Picture < ApplicationRecord
  belongs_to :story
  
  has_attached_file :image, styles: {
    medium: '300x300>'
  }
  
#  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_attachment :image, :content_type => { content_type: ["image/jpeg", "image/jpg", "image/gif", "image/png"] }, :size => { in: 0..2.megabytes }
end