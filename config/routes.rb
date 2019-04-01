Rails.application.routes.draw do
  root 'home#index'

  resources :items, only: [:index]

  namespace :merchants do 
    resources :users, only: [:index]
  end 

  resources :users, only: [:new, :create]

  get '/login', to: 'sessions#new'
  get '/cart', to: 'cart#show'

end
