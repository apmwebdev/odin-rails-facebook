Rails.application.routes.draw do
  resources :notifications, except: [:new, :edit]
  resources :friend_requests, except: [:edit, :update] do
    member do
      put "accept"
    end
  end
  resources :users, only: :index
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  authenticated :user do
    root to: 'home#newsfeed', as: :authenticated_root
  end
  root "home#landing_page"
end
