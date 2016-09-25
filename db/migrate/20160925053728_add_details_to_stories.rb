class AddDetailsToStories < ActiveRecord::Migration[5.0]
  def change
    add_column :stories, :final_title, :string
    add_column :stories, :final_body, :text
    add_column :stories, :published, :boolean, default: false
  end
end
