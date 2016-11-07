class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notified_by_user, class_name: "User"
  belongs_to :notification_category
  
  scope :unread, -> { where(read: false)}
end
