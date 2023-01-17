Rails.application.routes.draw do
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

  resources :users, only: [:index, :show, :new, :create] do
    collection do
      get "create_in_bulk"
      post "do_create_in_bulk"
    end
  end

  get "/profile", to: "users#profile"

  # Defines the root path route ("/")
  authenticated :user do
    root to: 'posts#index', as: :authenticated_root
  end
  root "home#landing_page"
end
