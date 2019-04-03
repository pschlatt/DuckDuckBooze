Rails.application.routes.draw do
  root 'home#index'

  resources :items, only: [:index, :show]

  namespace :merchants do
    resources :users, only: [:index]
  end

  namespace :admin do
    resources :merchants, only: [:show]
    resources :users, only: [:show]
  end

  namespace :dashboard do
    get '/', to: 'merchants#show'
  end

  resources :users, only: [:new, :create]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  get '/cart', to: 'cart#show'

  get '/profile', to: 'users#show'
end
