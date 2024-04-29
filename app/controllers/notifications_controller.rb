class NotificationsController < ApplicationController

	def index
		notifications = current_user.notifications
		if notifications.present?
	      render json: notifications, root: "data", each_serializer: NotificationSerializer, adapter: :json
	     # render json: @blogs, root: "data", adapter: :json
	    else
	      render json: {errors: "No notifications"}, status: :unprocessable_entity
	    end
	end

	def update
		notification = Notification.find_by(id: params[:id].to_i)
		if notification
			if notification.is_read == false
			   notification.update(is_read: true)
			   render json: {notification: "Readed notification"}, status: :ok
			else
			   render json: {errors: "already Readed"}, status: :ok
			end
		end
	end
end
