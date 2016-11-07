class NotificationCategory < ApplicationRecord
  has_many :notifications, dependent: :destroy
end
