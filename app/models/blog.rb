class Blog < ApplicationRecord
	belongs_to :user 
	has_one_attached :blog_image
	has_many :likes, dependent: :destroy
	has_many :bookmarks, dependent: :destroy
	has_many :comment_posts
end
