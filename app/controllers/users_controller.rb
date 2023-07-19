class UsersController < ApplicationController

	def sign_up #for create new user
  	user = User.new(email: params[:user][:email], password: params[:user][:password])
		if user.save
      render json: {date: user}, status: :created
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
       render json: {data: user}, status: :ok
      else
       render json: {errors: "Invalid email or password"}, status: :unprocessable_entity
      end
    else
     render json: {errors: "Email Not found, please enter correct email."}
    end
  end 
end
