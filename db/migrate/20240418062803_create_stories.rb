class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.integer :user_id
      t.string :title
      t.string :seen_ids, array: true, default: []
      
      t.timestamps
    end
  end
end
