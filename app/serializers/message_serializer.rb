class MessageSerializer < ActiveModel::Serializer
  attributes *[
      :id,
      :image,
    ]

    attribute :image do |object|
      host = ENV["API_BASE_URL"] || ''
      if @object.message_image.attached?
          {
              id: @object.message_image.id,
              url: host + Rails.application.routes.url_helpers.rails_blob_url( @object.message_image, only_path: true),
              blob: @object.message_image.blob.content_type
          }
      end
    end
    
end
