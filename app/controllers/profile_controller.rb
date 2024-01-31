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
end
