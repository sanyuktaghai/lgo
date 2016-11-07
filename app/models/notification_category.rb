class NotificationCategory < ApplicationRecord
  has_many :notifications, dependent: :destroy
  
  validates_uniqueness_of :name
end
