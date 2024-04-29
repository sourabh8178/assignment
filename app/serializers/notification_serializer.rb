class NotificationSerializer < ActiveModel::Serializer
  attributes *[
      :id,
      :message,
      :user_id,
      :current_user_id,
      :created_at,
      :notification_type,
      :url_id,
      :heading,
      :is_read,
      :user_profile,
      :image
    ]

    attribute :heading do |object|
      Profile.find_by(user_id: @object.current_user_id).name + " " + @object.message
    end

    attribute :user_profile do |object|
      profile = Profile.find_by(user_id: @object.current_user_id)
      host = ENV["API_BASE_URL"] || ''
      if profile.profile_image.attached?
          {
              id: profile.profile_image.id,
              url: host + Rails.application.routes.url_helpers.rails_blob_url( profile.profile_image, only_path: true)
          }
      end
    end

    attribute :image do |object|
      host = ENV["API_BASE_URL"] || ''
      if @object.notification_type != "follow"
        blog  = Blog.find_by_id(@object.url_id)
        if blog.blog_image.attached?
          {
              id: blog.blog_image.id,
              url: host + Rails.application.routes.url_helpers.rails_blob_url( blog.blog_image, only_path: true),
              blob: blog.blog_image.blob.content_type
          }
        end
      end
    end

    attribute :created_at do |object|
      @object.created_at.strftime('%B %d, %Y')
    end

end
