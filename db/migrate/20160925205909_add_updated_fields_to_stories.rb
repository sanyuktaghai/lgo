class AddUpdatedFieldsToStories < ActiveRecord::Migration[5.0]
  def change
    add_column :stories, :updated_title, :string
    add_column :stories, :updated_body, :text
  end
end
