class AddColomnToBlog < ActiveRecord::Migration[7.0]
  def change
    add_column :blogs, :blog_type, :string
  end
end
