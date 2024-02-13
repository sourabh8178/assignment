class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :reciver_id
      t.string :text

      t.timestamps
    end
  end
end
