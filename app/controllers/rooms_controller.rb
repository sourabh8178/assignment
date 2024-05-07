class RoomsController < ApplicationController
	before_action :authenticate_user!
	
	def create
	  room = Room.find_or_initialize_by(sendBy: current_user.id, sendTo: params[:sendTo])
	  if room.new_record?
	    room = Room.find_or_initialize_by(sendBy: params[:sendTo], sendTo: current_user.id)
	  end
	  if room.new_record?
	    if room.save
	      render json: { room: "Room created" }, status: :ok
	    else
	      render json: { errors: room.errors.full_messages }, status: :unprocessable_entity
	    end
	  else
	    render json: { room: "Room already exists" }, status: :ok
	  end
	  # params[:message][:text]
	end

	def my_room
		user_ids = Room.where(sendTo:current_user.id).pluck(:sendBy) + Room.where(sendBy:current_user.id).pluck(:sendTo)
		if user_ids.present?
	   	profiles = Profile.where(user_id: user_ids).order(updated_at: :desc)
      render json: profiles,  each_serializer: RoomSerializer
    else
      render json: {errors: "No room present"}, status: :ok
    end
	end
end
