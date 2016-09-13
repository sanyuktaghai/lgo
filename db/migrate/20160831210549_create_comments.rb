class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :story, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
#    add_foreign_key :comments, :stories
#    add_foreign_key :comments, :users
  end
end
