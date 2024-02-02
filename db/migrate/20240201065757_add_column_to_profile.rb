class AddColumnToProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :gender, :string
    add_column :profiles, :country, :string
    add_column :profiles, :city, :string
    add_column :profiles, :address, :string
    add_column :profiles, :zip_code, :string
    add_column :profiles, :date_birth, :date
  end
end
