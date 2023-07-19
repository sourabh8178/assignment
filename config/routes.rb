Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "blogs", to: "blogs#index"
  post "/users/sign_up" => "users#sign_up"
  post "/users/login" => "users#login" 
  
  root "blogs#index"
end
