Rails.application.routes.draw do
  root 'home#index'

  resources :items, only: [:index]

  namespace :merchants do
    resources :users, only: [:index]
  end

  resources :users, only: [:new, :create]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/cart', to: 'cart#show'

  get '/profile', to: 'users#show'

end
