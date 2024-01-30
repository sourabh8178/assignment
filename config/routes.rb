Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "blogs", to: "blogs#index"
  post "blogs", to: "blogs#create"
  get "blog/:id", to: "blogs#show"
  post "/users/sign_up" => "users#sign_up"
  post "/users/login" => "users#login" 
  post "/users/logout" => "users#logout"
  
  root "blogs#index"
end
