class FollowController < ApplicationController
	before_action :authenticate_user!

	def follow_user
	  @follow = Follow.find_or_initialize_by(user_id: @current_user.id, sender_id: params[:id].to_i)
		if @follow.save
			Notification.create(current_user_id: current_user.id, message: "is following you", user_id: params[:id].to_i, url_id: current_user.id, notification_type: "follow")
	  	render json: {errors: "Follow successful"}, status: :ok
    else
      render json: {errors: "Not able to follow"}, status: :unprocessable_entity
    end
	end

	def unfollow_user
		@follow = Follow.find_by(user_id: current_user.id, sender_id: params[:id].to_i)
		if @follow.destroy
			notification = Notification.create(current_user_id: current_user.id, user_id: params[:id].to_i, url_id: params[:id].to_i)
	  	notification.destroy
	  	render json: {errors: "Unfollow successful"}, status: :ok
    else
      render json: {errors: "Not able to unfollow"}, status: :unprocessable_entity
    end
	end
end
