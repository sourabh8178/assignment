class FollowController < ApplicationController
	before_action :authenticate_user!

	def follow_user
	  @follow = Follow.find_or_initialize_by(user_id: @current_user.id, sender_id: params[:id].to_i)
		if @follow.save
	  	render json: {errors: "Follow successful"}, status: :ok
    else
      render json: {errors: "Not able to follow"}, status: :unprocessable_entity
    end
	end

	def unfollow_user
		@follow = Follow.find_by(user_id: current_user.id, sender_id: params[:id].to_i)
		if @follow.destroy
	  	render json: {errors: "Unfollow successful"}, status: :ok
    else
      render json: {errors: "Not able to unfollow"}, status: :unprocessable_entity
    end
	end
end
