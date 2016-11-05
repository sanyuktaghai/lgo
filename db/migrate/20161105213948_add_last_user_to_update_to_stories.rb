class AddLastUserToUpdateToStories < ActiveRecord::Migration[5.0]
  def change
    add_column :stories, :last_user_to_update, :string
  end
end
