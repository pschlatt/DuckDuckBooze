Rails.application.routes.draw do
  root 'home#index'

  resources :items, only: [:index, :show]

  namespace :merchants do
    resources :users, only: [:index]
  end

  resources :users, only: [:new, :create]

  get '/login', to: 'sessions#new'
  get '/cart', to: 'cart#show'
  get '/profile', to: 'user#show'
end
