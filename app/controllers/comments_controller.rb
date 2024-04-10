class CommentsController < ApplicationController
	before_action :authenticate_user!

	def comment_post
		@comments = CommentPost.where(blog_id: params[:id].to_i)
		if @comments.present?
		 # render json: @comment, root: "data", adapter: :json
		 render json: @comments, root: "data", each_serializer: CommentsPostsSerializer, adapter: :json
		else
		 render json: {errors: "No comment avalable"}, status: :unprocessable_entity
		end
	end

	def create
		comment = current_user.comment_posts.new(message: params[:comment], blog_id: params[:post_id].to_i)
		if comment.save
      render json: {commnet: "commnet created successfull"}
    else
      render json: {errors: comment.errors.full_messages.join(', ')}
    end
	end

end
