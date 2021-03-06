Rails.application.routes.draw do
  
  get 'books/new'
  get 'topics/new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  root 'home#index'
  
  resources :users do
    member do
      get :following, :followers, :this_user_topics
    end
  end
  
  resources :topics
  
  resources :follows, only: [:create, :destroy]
  
  get '/favorites', to: 'favorites#index'
  
  post '/favorites', to: 'favorites#create'
  
  delete '/favorites_delete', to: 'favorites#destroy'
  
  get '/comment_new', to: 'comments#new'
  
  post '/comments', to: 'comments#create'
  
  delete '/comment_delete', to: 'comments#destroy'
  
  resources :books
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
