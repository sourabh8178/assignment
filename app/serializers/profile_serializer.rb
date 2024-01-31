class ProfileSerializer < ActiveModel::Serializer
    attributes *[
      :id,
      :name,
      :user_name,
      :user_id,
      :profile_image,
      :profile_background_image,
      :instagram_url,
      :youtub_url,
      :linkedin_url,
      :created_at,
      :updated_at
    ]

    attribute :profile_image do |object|
    	debugger
      host = ENV["API_BASE_URL"] || ''
      if @object.profile_image.attached?
          {
              id: @object.profile_image.id,
              url: host + Rails.application.routes.url_helpers.rails_blob_url( @object.profile_image, only_path: true)
          }
      end
    end

    attribute :profile_background_image do |object|
      host = ENV["API_BASE_URL"] || ''
      if @object.profile_image.attached?
          {
              id: @object.profile_image.id,
              url: host + Rails.application.routes.url_helpers.rails_blob_url( @object.profile_image, only_path: true)
          }
      end
    end

end
