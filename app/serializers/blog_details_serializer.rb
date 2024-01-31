class BlogDetailsSerializer < ActiveModel::Serializer
    attributes *[
      :id,
      :title,
      :body,
      :user_id,
      :blog_image
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
end
