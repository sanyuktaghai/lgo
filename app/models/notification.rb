class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :reaction_category
end
