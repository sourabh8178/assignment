class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.string :message
      t.integer :user_id
      t.string :notification_type
      t.boolean :is_read, default: false
      t.integer :current_user_id
      t.integer :url_id

      t.timestamps
    end
  end
end
