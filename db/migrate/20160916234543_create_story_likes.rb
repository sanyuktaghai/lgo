class CreateStoryLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :story_likes do |t|
      t.references :user, foreign_key: true
      t.references :story, foreign_key: true

      t.timestamps
    end
  end
end
