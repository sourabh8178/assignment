class ProfileSerializer < ActiveModel::Serializer
    attributes *[
      :id,
      :name,
      :user_name,
      :user_id,
      :about,
      :profile_image,
      :profile_background_image,
      :instagram_url,
      :youtub_url,
      :linkedin_url,
      :created_at,
      :updated_at,
      :location,
      :gender,
      :country,
      :city,
      :address,
      :zip_code,
      :date_birth,
      :follow
    ]
 
    attribute :profile_image do |object|
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
      if @object.profile_background_image.attached?
          {
              id: @object.profile_background_image.id,
              url: host + Rails.application.routes.url_helpers.rails_blob_url( @object.profile_background_image, only_path: true)
          }
      end
    end

    attribute :created_at do |object|
    	@object.created_at.strftime('%B %d, %Y')
    end

    attribute :follow do |object|
     follow = Follow.where(user_id: current_user.id, sender_id: @object.user_id)
     if follow.present?
      true
     else
      false
     end
    end

end
