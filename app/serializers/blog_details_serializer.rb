class BlogDetailsSerializer < ActiveModel::Serializer
    attributes *[
      :id,
      :title,
      :body,
      :user_id,
      :blog_image,
      :likes_count,
      :likes,
      :profile,
      :liked,
      :bookmarked,
      :is_current_user_post,
    ]

    attribute :blog_image do |object|
      host = ENV["API_BASE_URL"] || ''
      if @object.blog_image.attached?
          {
              id: @object.blog_image.id,
              url: host + Rails.application.routes.url_helpers.rails_blob_url( @object.blog_image, only_path: true),
              blob: @object.blog_image.blob.content_type
          }
      end
    end

    attribute :profile do |object|
      if @object&.user&.profile.present?
        profile_image = @object.user.profile.url_profile
        # @object.user.profile.attributes.merge(image: profile_image)
        name  = @object.user.profile.name
        id = @object.user.profile.id
        {image: profile_image, name: name, id: id}
      end
    end

    attribute :liked do |object|
      @object.likes.exists?(user_id: current_user.id)
    end

    attribute :bookmarked do |object|
      @object.bookmarks.exists?(user_id: current_user.id)
    end

    attribute :likes_count do |object|
      @object.likes.count
    end

    attribute :likes do |object|
      User.where(id:@object.likes.map(&:user_id))&.map(&:profile)&.map{|p| p.url_profile}
    end

    attribute :is_current_user_post do |object|
      current_user.id == @object.user_id
    end

end
