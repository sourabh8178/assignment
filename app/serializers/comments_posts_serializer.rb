class CommentsPostsSerializer < ActiveModel::Serializer
  attributes *[
      :id,
      :user_id,
      :post_id,
      :created_at,
      :message,
      :profile
    ]

    attribute :profile do |object|
      if @object&.user&.profile.present?
        profile_image = @object.user.profile.url_profile
        name  = @object.user.profile.name
        id = @object.user.profile.id
        {image: profile_image, name: name, id: id}
      end
    end
end
