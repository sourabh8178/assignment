class ApplicationController < ActionController::Base
 skip_before_action :verify_authenticity_token  
 helper_method :current_user
 
 def current_user
  @current_user ||= User.where(authentication_token: request.headers['Token']).first
 end

 def authenticate_user!
  return render json:{error:'401 Unauthorized!'},status: 401 unless current_user
 end
 
end
