Rails.application.routes.draw do
  resources :friend_requests, except: [:edit, :update]
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  authenticated :user do
    root to: 'home#newsfeed', as: :authenticated_root
  end
  root "home#landing_page"
end
