class Blog < ApplicationRecord
	default_scope { order(created_at: :desc) }
	belongs_to :user 
	has_one_attached :blog_image
	has_many :likes, dependent: :destroy
	has_many :bookmarks, dependent: :destroy
	has_many :comment_posts

	def url_blog
		host = ENV["API_BASE_URL"] || ''
		if self.blog_image.attached?
          {
              id: self.blog_image.id,
              url: host + Rails.application.routes.url_helpers.rails_blob_url( self.blog_image, only_path: true)
          }
      end
	end
end
