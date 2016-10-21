class AddMinorDetailstoUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :gender, :string
    add_column :users, :age_range, :string
    add_column :users, :image, :string
  end
end
