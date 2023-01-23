Rails.application.routes.draw do
  resources :user_profiles, only: [:show, :edit, :update]
  resources :likes, only: [:new, :create, :destroy]
  resources :comments, except: [:index, :show]
  resources :posts
  resources :notifications, except: [:new, :edit]

  resources :friend_requests, only: [:index, :create, :destroy] do
    member do
      post "accept"
    end
  end

  devise_for :users,
    controllers: { omniauth_callbacks: "users/omniauth_callbacks",
      registrations: "users/registrations",
      confirmations: "users/confirmations" }
  get "/profile", to: "users#profile"

  # Defines the root path route ("/")
  authenticated :user do
    root to: 'posts#index', as: :authenticated_root
  end
  root "home#landing_page"

  # Admin-only routes
  authenticated :user, lambda { |user| user.admin? } do
    get "create_profiles_for_existing_users",
      to: "user_profiles#create_for_existing_users"
    get "users/create_in_bulk"
    post "users/do_create_in_bulk"
  end

  # Needs to be last so that other things are checked before :show
  resources :users, only: [:index, :show, :new, :create]
end
