class AddUserIdToStories < ActiveRecord::Migration[5.0]
  def change
    add_reference :stories, :user, foreign_key: true
    add_foreign_key :stories, :users
  end
end

#command: $rails generate migration add_user_id_to_stories user:references