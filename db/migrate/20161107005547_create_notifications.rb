class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.references :notified_by_user, references: :users
      t.references :notification_category, foreign_key: true
      t.boolean :read
      t.integer :origin_id
      
      t.timestamps
    end
  end
end
