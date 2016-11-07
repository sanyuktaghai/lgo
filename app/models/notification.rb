class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notified_by_user_id, class_name: "User"
  belongs_to :notification_category
end
