class BlogSerializer < ActiveModel::Serializer
    attributes *[
      :id,
      :title,
      :body,
      :created_at,
      :user_id,
      :blog_image,
      :profile,
      :liked,
      :comments,
      :likes
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
        @object.user.profile.attributes.merge(image: profile_image)
      end
    end

    attribute :liked do |object|
      @object.likes.exists?(user_id: current_user.id)
    end

    attribute :comments do |object|
      @object.comment_posts
    end

    attribute :likes do |object|
      User.where(id:@object.likes.map(&:user_id))&.map(&:profile)&.map{|p| p.url_profile}
    end

    attribute :created_at do |object|
      @object.created_at.strftime('%B %d, %Y')
    end

end
