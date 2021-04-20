Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'users', to: 'users#index'
  put '/make_admin/:id' , to:'users#make_admin'
  put '/cancel_admin/:id' , to:'users#cancel_admin_rights'
  get '/users/:id' , to:'users#show'
  root 'home_page#index'
  get '/articles/:category', to:'articles#index'
  get '/articles', category: 'all', to:'articles#index'
  resources :articles, only: [:new, :create, :show, :edit, :update, :destroy]
end
