class ProfileController < ApplicationController
	before_action :authenticate_user!

	def following_lists
		user_ids = Follow.where(user_id: @current_user.id).pluck(:sender_id)
		@profiles = @profiles = Profile.where(user_id: user_ids)

		if @profiles
			render json: @profiles, each_serializer: ProfileDetailsSerializer
    else
      render json: {errors: "Not a following list"}, status: :unprocessable_entity
    end
	end

	def follower_lists
		user_ids = Follow.where(sender_id: @current_user.id).pluck(:user_id)
		@profiles = Profile.where(id: user_ids)

		if @profiles
			render json: @profiles, each_serializer: ProfileDetailsSerializer
      # render json: @profile, root: "profile", adapter: :json
    else
      render json: {errors: "Not a follower lists"}, status: :unprocessable_entity
    end
	end

	def create
		@profile = Profile.new(profile_create_params)
		@profile.user_id = @current_user.id
		if @profile.save
      render json: @profile, root: "profile", adapter: :json
    else
      render json: {errors: "Not able to create"}, status: :unprocessable_entity
    end
	end

	def show
		@profile = Profile.find_by(id: params[:id].to_i)
		if @profile
      render json: @profile, each_serializer: ProfileDetailsSerializer
    else
      render json: {errors: "Profile is not found"}, status: :unprocessable_entity
    end
	end

	def view_profile
		@profile = @current_user.profile
		if @profile.present?
      render json: @profile, root: "data", adapter: :json
    else
      render json: {errors: "Profile is not found"}, status: :unprocessable_entity
    end
	end

	def view_profile_with_all_data
		@profile = Profile.last
		# @profile = @current_user.profile
		if @profile
			render json: @profile, each_serializer: ProfileWithAllDataSerializer
      # render json: @profile, root: "data", adapter: :json
    else
      render json: {errors: "Profile is not found"}
    end
	end

	def update_profile
		@profile = @current_user.profile.update(profile_params)
		if @profile
      render json: @profile, root: "data", adapter: :json
    else
      render json: {errors: "Profile can't update"}
    end
	end

	def search
		@profiles = Profile.where("name LIKE ?", "%#{params[:name]}%")
		if @profiles
			render json: @profiles, each_serializer: ProfileDetailsSerializer
    else
      render json: {errors: "No user find"}
    end
	end

	private

	 def profile_params
	  params.require(:editedData).permit(:name, :user_name, :gender, :about, :location, :country, :city, :address, :zipcode, :date_birth, :instagram_url, :youtub_url, :linkedin_url, :profile_image, :profile_background_image)
	 end

	 def profile_create_params
	 	params.permit( :name, :user_name, :date_birth, :gender, :about, :country, :city, :zip_code, :address, :instagram_url, :youtub_url, :linkedin_url, :profile_image, :profile_background_image
    )
	 end
end
