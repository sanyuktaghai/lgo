class Reaction < ApplicationRecord
  belongs_to :story
  belongs_to :reaction_category
  belongs_to :user
end
