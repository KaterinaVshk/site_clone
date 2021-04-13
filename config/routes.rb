Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  root 'home_page#index'
  get '/news/:category', to:'articles#index'
  get '/news', category: 'all', to:'articles#index'
  get '/news/new' , to: 'articles#new'
  post '/news', to: 'articles#create' 
  get	'/news/:id', to: 'articles#show'
  get	'/news/:id/edit', to:	'articles#edit'
  patch '/news/:id', to: 'articles#update'
  delete	'/news/:id', to: 'articles#destroy'
end
