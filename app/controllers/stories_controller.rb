class StoriesController < ApplicationController
	before_action :authenticate_user!

	def create
		if current_user.story.present?
	   	render json: {errors: "already present the story"}
	  else
		 story = Story.new
		 story.title = params[:title]
		 story.story_image = params[:story_image]
		 story.user_id = current_user.id
		 if story.save
	      render json: story, root: "data", adapter: :json
	    else
	      render json: {errors: "Not able to create"}
	    end
	  end
	end

	def user_stories
		users_with_stories = User.where(id: current_user.follows.map(&:sender_id)).select { |user| user.story.present? }
		if users_with_stories.present?
     render json: users_with_stories, root: "data", each_serializer: StoriesSerializer, adapter: :json
    else
      render json: {errors: "No story Present"}, status: :unprocessable_entity
    end
	end

	def current_user_story
		if current_user.story.present?
			story = User.where(id: current_user.id)
     render json: story, root: "data", each_serializer: StoriesSerializer, adapter: :json
    else
      render json: {errors: "No story Present"}, status: :unprocessable_entity
    end
	end

	def mark_as_seen
		story = Story.find_by_id(params[:id])
		if story.present?
		  unless story.seen_ids.include?(current_user.id.to_s)
		    story.seen_ids << current_user.id
		    story.save
		  end
		end
	end

	def delete
		story =Story.find_by_id(params[:id])
		if story.destroy
			render json: {errors: "Deleted successful"}, status: :ok
		else
			render json: {errors: "Not able to delete"}, status: :unprocessable_entity
		end
	end
end
