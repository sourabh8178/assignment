class ProfileController < ApplicationController
	before_action :authenticate_user!

	def create
		@profile = Profile.new
		@profile.name = params[:name]
		@profile.user_name = params[:user_name]
		@profile.profile_image = params[:profile_image]
		@profile.profile_background_image = params[:profile_background_image]
		@profile.instagram_url = params[:instagram_url]
		@profile.youtub_url = params[:youtub_url]
		@profile.linkedin_url = params[:linkedin_url]
		@profile.user_id = @current_user.id
		@profile.about = params[:about]
		if @profile.save
      render json: @profile, root: "profile", adapter: :json
    else
      render json: {errors: "Not able to create"}
    end
	end

	def show
		@profile = Profile.find_by(id: params[:id].to_i)
		if @profile
      render json: @profile, root: "data", adapter: :json
    else
      render json: {errors: "Profile is not found"}
    end
	end

	def view_profile
		@profile = @current_user.profile
		if @profile
      render json: @profile, root: "data", adapter: :json
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

	private

	 def profile_params
	  params.require(:editedData).permit(:name, :user_name, :gender, :about, :location, :country, :city, :address, :zipcode, :date_birth, :instagram_url, :youtub_url, :linkedin_url, :profile_image, :profile_background_image)
	 end
end
