class UpdateStoryColumnNames < ActiveRecord::Migration[5.0]
  def change
    rename_column :stories, :body, :raw_body
    rename_column :stories, :title, :raw_title
  end
end
