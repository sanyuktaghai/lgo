class AddReviewToStories < ActiveRecord::Migration[5.0]
  def change 
    add_column :stories, :review, :boolean, default: false
  end
end
