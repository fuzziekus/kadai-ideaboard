Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create]
  resources :ideas
  resources :favorites, only: [:index, :create, :destroy]
  resources :comments, only: [:create, :destroy]
  
  get 'rankings/fav', to: 'rankings#fav'
end
