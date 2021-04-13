Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  root 'home_page#index'
  get '/articles/:category', to:'articles#index'
  get '/articles', category: 'all', to:'articles#index'
  resources :articles, only: [:new, :create, :show, :edit, :update, :destroy]
end
