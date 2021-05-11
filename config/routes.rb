Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  resources :users, only: [:index, :edit, :update] 
  put '/make_admin/:id' , to:'users#make_admin'
  put '/cancel_admin/:id' , to:'users#cancel_admin_rights'
  get '/users/:id' , to:'users#show'
  get '/news/:category', to:'articles#index'
  root :to => "articles#index", :category => 'all'
  post '/preferences' , to: 'preferences#create', as: 'preference_create'
  resources :articles, only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :comments
  end
  resources :comments do
    resources :comments
  end
  get '/search' => 'articles#search', :as => 'search_article'
end
