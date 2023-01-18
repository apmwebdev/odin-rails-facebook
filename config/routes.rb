Rails.application.routes.draw do
  resources :users_profile, only: [:show, :edit, :update]
  resources :likes, only: [:new, :create, :destroy]
  resources :comments, except: [:index, :show]
  resources :posts
  resources :notifications, except: [:new, :edit]

  resources :friend_requests, only: [:index, :create, :destroy] do
    member do
      post "accept"
    end
  end

  devise_for :users
  get "/profile", to: "users#profile"
  resources :users, only: [:index, :show, :new, :create] do
    collection do
      get "create_in_bulk"
      post "do_create_in_bulk"
    end
  end

  # Defines the root path route ("/")
  authenticated :user do
    root to: 'posts#index', as: :authenticated_root
  end
  root "home#landing_page"

  # Admin-only routes
  authenticated :user, lambda { |user| user.admin? } do
    get "create_profiles_for_existing_users",
      to: "user_profiles#create_for_existing_users"
  end
end
