class BlogsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @blogs = Blog.all
    if @blogs.present?
      render json: {blogs: @blogs}
    else
      render json: {errors: "No Blogs Present"}
    end
  end
end
