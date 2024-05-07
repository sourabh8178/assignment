class UsersController < ApplicationController

	def sign_up #for create new user
  	user = User.new(email: params[:user][:email].strip, password: params[:user][:password])
		if user.save!
      profile_present = user.profile.present?
      render json: { data: user, profile_present: profile_present }, status: :created
		else  	
			render json: {errors: user.errors}, status: :unprocessable_entity
		end
  end

	def login #for user login
    require 'bcrypt'
    user = User.find_by_email(params[:user][:email])
    password =  params[:user][:password]

    if user.present?
      my_password = BCrypt::Password.new(user.password) #encrypt the password
      if my_password == password
       profile_present = user.profile.present?
       render json: {data: user, profile_present: profile_present}, status: :ok
      else
       render json: {errors: "Invalid email or password"}, status: :unprocessable_entity
      end
    else
     render json: {errors: "Email Not found, please enter correct email."}, status: :unprocessable_entity
    end
  end

  def check_email
    user = User.find_by_email(params[:email])
    if user.present?
       render json: {data: user}, status: :ok
    else
     render json: {errors: "Please enter the valid email"}, status: :unprocessable_entity
    end
  end

  def forget_password
    user = User.find_by_email(params[:email])
    # user.update(password: params[:password])
    if user.update(password: params[:password])
      render json: {data: user}, status: :ok
    else
     render json: {errors: "Password cant be changed"}, status: :unprocessable_entity
    end
  end

  def logout
    # authorization_header = request.headers['Authorization']
    # token = authorization_header.split(' ').last
    # user = User.find_by(authentication_token: token)
    # user.update(authentication_token: nil)
  end

end
