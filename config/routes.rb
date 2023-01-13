Rails.application.routes.draw do
  get "/landing_page", to: "home#landing_page"
  get "/newsfeed", to: "home#newsfeed"
  resources :friend_requests
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#landing_page"
end
