class UpdateStoryColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :stories, :admin_updated_at, :admin_published_at
  end
end
