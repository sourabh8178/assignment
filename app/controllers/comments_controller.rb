class CommentsController < ApplicationController

	def comment_post
		@comments = CommentPost.where(post_id: params[:id].to_i)
		if @comments.present?
		 # render json: @comment, root: "data", adapter: :json
		 render json: @comments, root: "data", each_serializer: CommentsPostsSerializer, adapter: :json
		else
		 render json: {errors: "Comment is not found"}, status: :unprocessable_entity
		end
	end

end
