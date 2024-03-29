class BlogSerializer < ActiveModel::Serializer
    attributes *[
      :id,
      :title,
      :body,
      :created_at,
      :updated_at,
      :user_id,
      :blog_image,
      :profile,
      :liked,
      :bookmarked
    ]

    attribute :blog_image do |object|
      host = ENV["API_BASE_URL"] || ''
      if @object.blog_image.attached?
          {
              id: @object.blog_image.id,
              url: host + Rails.application.routes.url_helpers.rails_blob_url( @object.blog_image, only_path: true)
          }
      end
    end

    attribute :profile do |object|
      if @object&.user&.profile.present?
        profile_image = @object.user.profile.url_profile
        @object.user.profile.attributes.merge(image: profile_image)
      end
    end

    attribute :liked do |object|
      @object.likes.exists?(user_id: current_user.id)
    end

    attribute :bookmarked do |object|
      @object.bookmarks.exists?(user_id: current_user.id)
    end

end
