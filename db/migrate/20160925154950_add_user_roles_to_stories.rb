class AddUserRolesToStories < ActiveRecord::Migration[5.0]
  def change
    add_reference :stories, :admin, index: true
    add_reference :stories, :author, index: true
    add_reference :stories, :poster, index: true
    
    add_foreign_key :stories, :users, column: :admin_id
    add_foreign_key :stories, :users, column: :author_id
    add_foreign_key :stories, :users, column: :poster_id
  end
end