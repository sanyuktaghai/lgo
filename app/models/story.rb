class Story < ApplicationRecord
  validates :raw_title, presence: true
  validates :raw_body, presence: true
  
  attr_accessor :validate_final_fields
  attr_accessor :validate_updated_fields
  def validate_final_fields?
    validate_final_fields == 'true' || validate_final_fields == true
  end
  def validate_updated_fields?
    validate_updated_fields == 'true' || validate_updated_fields == true
  end
  validates :final_title, presence: true, if: :validate_final_fields?
  validates :final_body, presence: true, if: :validate_final_fields?
  validates :updated_title, presence: true, if: :validate_updated_fields?
  validates :updated_body, presence: true, if: :validate_updated_fields?
  
  belongs_to :user
  
  has_many :comments, dependent: :destroy  # If story gets deleted, the depending comment also gets deleted
  has_many :story_likes, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :pictures, dependent: :destroy
  accepts_nested_attributes_for :pictures, reject_if: :all_blank
  
#  def pictures_array=(array)
#    array.each do |picture|
#      pictures.build(:pictures => picture)
#    end
#  end
  
  default_scope { order(created_at: :desc)}
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }
end