class StoriesSerializer < ActiveModel::Serializer
	attributes *[
      :id,
      :name,
      :profile_image,
      :stories,
      :seen,
      :story_id,
      :title,
      :seen_users,
      :created_at
    ]
 
    attribute :profile_image do |object|
      host = ENV["API_BASE_URL"] || ''
      if @object.profile.profile_image.attached?
          {
              id: @object.profile.profile_image.id,
              url: host + Rails.application.routes.url_helpers.rails_blob_url( @object.profile.profile_image, only_path: true)
          }
      end
    end

    attribute :stories do |object|
    	host = ENV["API_BASE_URL"] || ''
		  if @object.story && @object.story.story_image.attached?
        {
	        id: @object.story.story_image.id,
	        story_id: @object.story.id,
	        url: host + Rails.application.routes.url_helpers.rails_blob_url( @object.story.story_image, only_path: true)
        }
	    end
    end

    attribute :name do |object|
    	@object.profile.name
    end

    attribute :seen do |object|
      if @object.story
  	    @object.story.seen_ids.include?(current_user.id.to_s)
      end
    end

    attribute :story_id do |object|
      @object.story.id
    end

    attribute :title do |object|
      if @object.story.title.present?
        @object.story.title
      end
    end

    attribute :seen_users do |object|
      if @object.story
        Profile.where(user_id: @object.story.seen_ids).map{|image| image.url_profile.merge(name: image.name)}
      end
    end

    attribute :created_at do |object|
      @object.created_at.strftime('%B %d, %Y')
    end

end