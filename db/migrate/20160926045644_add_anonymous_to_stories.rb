class AddAnonymousToStories < ActiveRecord::Migration[5.0]
  def change
    add_column :stories, :anonymous, :boolean
  end
end
