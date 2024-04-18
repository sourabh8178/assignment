class StoriesSerializer < ActiveModel::Serializer
	attributes *[
      :id,
      :name,
      :profile_image,
      :stories,
      :seen
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
    	image_urls = []
    	@object.blogs.where(blog_type: "story").each do |blog|
			if blog.blog_image.attached?
		      image_urls << {
		        id: blog.blog_image.id,
		        blog_id: blog.id,
		        url: host + Rails.application.routes.url_helpers.rails_blob_url( blog.blog_image, only_path: true)
		      }
		    end
		end
		image_urls
    end

    attribute :name do |object|
    	@object.profile.name
    end

    attribute :seen do |object|
    	seen = []
	    @object.blogs.where(blog_type: "story").each do |blog|
			  seen << blog.seen_ids.include?(current_user.id)
			end
			seen
    end
end