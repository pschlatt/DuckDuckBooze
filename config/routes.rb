Rails.application.routes.draw do
  root 'home#index'

  resources :items, only: [:index, :show]

  namespace :merchants do
    resources :users, only: [:index]
  end

  namespace :admins do
    resources :users, only: [:index]

    get '/dashboard', to: 'dashboard#show'
  end

  namespace :dashboard do
    get '/', to: 'merchants#show'
  end

  resources :users, only: [:new, :create]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'session#destroy'
  
  get '/cart', to: 'cart#show'

  get '/profile', to: 'users#show'
end
