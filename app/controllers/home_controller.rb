class HomeController < ApplicationController
  def create
    
  end

  def index


    # @user = User.last
    # # @users = User.all
    # # respond_to do |format|
    # #   debugger
    # #   format.html
    # #   format.pdf do
    # #     pdf_data = render_to_string pdf: "users_list", locals: { user: @users }
    # #     render pdf: "users_list"
    # #   end
    # # end
    pdf = Rails.root.join('public', 'react.pdf')
    UserMailer.welcome_email(pdf).deliver_now
  end
end
