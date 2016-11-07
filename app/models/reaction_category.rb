class ReactionCategory < ApplicationRecord
  has_many :reactions, dependent: :destroy
  has_many :stories, through: :reactions
  
  validates_uniqueness_of :name
end
