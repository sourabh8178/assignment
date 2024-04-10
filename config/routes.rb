Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  get "blogs", to: "blogs#index"
  get "/user_blog", to: "blogs#user_blog"
  post "blogs", to: "blogs#create"
  get "blog/:id", to: "blogs#show"
  post "/users/sign_up" => "users#sign_up"
  post "/users/check_email" => "users#check_email"
  post "/users/forget_password" => "users#forget_password"
  post "/users/login" => "users#login"
  post "/users/logout" => "users#logout"
  post "/profile" => "profile#create"
  get "/profile/:id" => "profile#show"
  get "/view_profile" => "profile#view_profile"
  get "/view_profile_with_all_data" => "profile#view_profile_with_all_data"
  put "/update_profile" => "profile#update_profile"
  get "follower_lists" => "profile#follower_lists"
  get "following_lists" => "profile#following_lists"
  get "unfollow_user/:id" => "follow#unfollow_user"
  get "follow_user/:id" => "follow#follow_user"
  get "search_user" => "profile#search"
  post 'like/:id' => "blogs#like_blog"
  post 'unlike/:id' => "blogs#unlike_blog"
  get 'delete_blog/:id' => "blogs#delete"
  post '/bookmark/:id' => "blogs#bookmark_blog"
  post '/unbookmark/:id' => "blogs#unbookmark_blog"
  get '/comments/:id' => "comments#comment_post"
  post '/comment' => "comments#create"
  root "blogs#index"
end
