class Profile < ApplicationRecord
	belongs_to :user 
	has_one_attached :profile_image
	has_one_attached :profile_background_image

	def url_profile
		host = ENV["API_BASE_URL"] || ''
		if self.profile_image.attached?
          {
              id: self.profile_image.id,
              url: host + Rails.application.routes.url_helpers.rails_blob_url( self.profile_image, only_path: true)
          }
      end
	end
end
