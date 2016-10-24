class AddFbimageToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :fbimage, :string
  end
end
