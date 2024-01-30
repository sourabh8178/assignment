class ApplicationController < ActionController::Base
 skip_before_action :verify_authenticity_token  
 helper_method :current_user
 
 def current_user
  authorization_header = request.headers['Authorization']
  token = authorization_header.split(' ').last
  @current_user ||= User.find_by(authentication_token: token)
# @current_user ||= User.find_by(authentication_token: request.headers['Token'])
  # @current_user ||= User.find_by(authentication_token: authorization_header)
 end

 def authenticate_user!
  return render json:{error:'401 Unauthorized!'},status: 401 unless current_user
 end

end
