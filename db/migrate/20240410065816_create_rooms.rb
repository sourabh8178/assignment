class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.integer :sendBy
      t.integer :sendTo

      t.timestamps
    end
  end
end
