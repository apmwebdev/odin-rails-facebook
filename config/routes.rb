Rails.application.routes.draw do
  resources :notifications, except: [:new, :edit]
  resources :friend_requests, except: [:edit, :update] do
    member do
      put "accept"
    end
  end
  devise_for :users
  resources :users, only: [:index, :show, :new, :create] do
    collection do
      get "create_in_bulk"
      post "do_create_in_bulk"
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  authenticated :user do
    root to: 'home#newsfeed', as: :authenticated_root
  end
  root "home#landing_page"
end
