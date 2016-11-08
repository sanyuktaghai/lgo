class ReactionCategory < ApplicationRecord
  has_many :reactions, dependent: :destroy
  has_many :reaction_categories, through: :reactions
end
