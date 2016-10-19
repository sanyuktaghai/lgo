class AddStatustoUsers < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :status, :string
  end

  def down
    remove_column :users, :status
  end
end
