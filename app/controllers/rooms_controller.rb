class RoomsController < ApplicationController
	before_action :authenticate_user!
	
	def create
	  room = Room.find_or_initialize_by(sendBy: current_user.id, sendTo: params[:sendTo])
	  if room.save
      render json: {room: "Room created"}, status: :ok
    else
      render json: {errors: "Room can't created"}, status: :unprocessable_entity
    end
	end

	def my_room
		user_ids = Room.where(sendTo:current_user.id).pluck(:sendBy) + Room.where(sendBy:current_user.id).pluck(:sendTo)
		if user_ids.present?
	   	profiles = Profile.where(user_id: user_ids)
      render json: profiles,  each_serializer: RoomSerializer
    else
      render json: {errors: "No room present"}, status: :ok
    end
	end
end
