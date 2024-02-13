class ProfileDetailsSerializer < ActiveModel::Serializer
    attributes *[
      :id,
      :name,
      :user_name,
      :user_id,
      :profile_image,
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

    attribute :follow do |object|
     follow = Follow.where(user_id: current_user.id, sender_id: @object.user_id)
     if follow.present?
      true
     else
      false
     end
    end

end
