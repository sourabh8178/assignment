class BlogsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @blogs = Blog.all
    if @blogs.present?
      render json: @blogs, root: "data", each_serializer: BlogDetailsSerializer, adapter: :json
     # render json: @blogs, root: "data", adapter: :json
    else
      render json: {errors: "No Blogs Present"}, status: :unprocessable_entity
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

  def user_blog
    @blogs = @current_user.blogs
    if @blogs.present?
     # render json: @blogs, root: "data", adapter: :json
     render json: @blogs, root: "data", each_serializer: BlogDetailsSerializer, adapter: :json
    else
      render json: {errors: "No Blogs Present"}, status: :unprocessable_entity
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

  def like_blog
   like = Like.find_or_initialize_by(user_id: current_user.id, blog_id: params[:id].to_i)
    if like.save
      render json: {like: "liked the post"}, status: :ok
    else
      render json: {errors: like.errors.messages}, status: :unprocessable_entity
    end 
  end

  def unlike_blog
    like = Like.find_by(user_id: current_user.id, blog_id: params[:id].to_i)
    if like.destroy
      render json: {like: "unliked the post"}, status: :ok
    else
      render json: {errors: "unable to unlike the post"}, status: :unprocessable_entity
    end 
  end

  def bookmark_blog
    mark = Bookmark.find_or_initialize_by(user_id: current_user.id, blog_id: params[:id].to_i)
    if mark.save
        render json: {mark: "Bookmarked the post"}, status: :ok
    else
      render json: {errors: mark.errors.messages}, status: :unprocessable_entity
    end 
  end

  def unbookmark_blog
    like = Bookmark.find_by(user_id: current_user.id, blog_id: params[:id].to_i)
    if like.destroy
      render json: {like: "Bookmarked the post"}, status: :ok
    else
      render json: {errors: "unable to unlike the post"}, status: :unprocessable_entity
    end 
  end

  def delete
    blog = Blog.find_by(id: params[:id].to_i)
    if blog.destroy
      render json: {Post: "Post deleted"}, status: :ok
    else
      render json: {errors: "unable to delete the post"}, status: :unprocessable_entity
    end
  end
end
