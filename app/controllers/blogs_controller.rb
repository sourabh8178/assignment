class BlogsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @blogs = Blog.all
    if @blogs.present?
     render json: @blogs, root: "data", adapter: :json
    else
      render json: {errors: "No Blogs Present"}
    end
  end

  def create
    @blog = Blog.new
    @blog.title = params[:title]
    @blog.body = params[:body]
    @blog.blog_image = params[:image]
    @blog.user_id = @current_user.id
    if @blog.save
      render json: @blog, root: "data", adapter: :json
    else
      render json: {errors: "Not able to create"}
    end
  end

  def show
    @blog = Blog.find_by(id: params[:id].to_i)
    if @blog
      render json: @blog, root: "data", adapter: :json
    else
      render json: {errors: "Blog is not found"}
    end
  end
end
