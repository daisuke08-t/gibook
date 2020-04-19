Rails.application.routes.draw do
  
  get 'topics/new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  root 'home#index'
  
  resources :users do
    member do
      get :following, :followers
    end
  end
  
  resources :topics
  
  post '/favorites', to: 'favorites#create'
  
  delete '/favorites_delete', to: 'favorites#destroy'
  
  get '/comment_new', to: 'comments#new'
  
  post '/comments', to: 'comments#create'
  
  delete '/comment_delete', to: 'comments#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
