class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :user_name
      t.integer :user_id
      t.string :about
      t.string :instagram_url
      t.string :youtub_url
      t.string :linkedin_url
      t.timestamps
    end
  end
end
