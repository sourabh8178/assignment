class CreateCommentPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :comment_posts do |t|
      t.text :message
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
  end
end
