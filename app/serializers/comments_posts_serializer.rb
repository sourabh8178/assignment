class CommentsPostsSerializer < ActiveModel::Serializer
  attributes *[
      :id,
      :user_id,
      :profile_id,
      :created_at,
      :message,
      :profile_image,
      :name
    ]

    attribute :profile_image do |object|
      host = ENV["API_BASE_URL"] || ''
      if @object&.user&.profile.present?
          {
              id: @object.user&.profile.profile_image.id,
              url: host + Rails.application.routes.url_helpers.rails_blob_url( @object.user.profile.profile_image, only_path: true)
          }
      end
    end

    attribute :created_at do |object|
      @object.created_at.strftime('%B %d, %Y')
    end

    attribute :profile_id do |object|
      @object.user.profile.id
    end

    attribute :name do |object|
      @object.user.profile.name.capitalize
    end

    attribute :post_id do |object|
      @object.blog.id
    end
end
