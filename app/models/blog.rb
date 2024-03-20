class Blog < ApplicationRecord
	belongs_to :user 
	has_one_attached :blog_image
	has_many :likes
	has_many :bookmarks
end
