class Blog < ApplicationRecord
	belongs_to :user 
	has_one_attached :blog_image
end
