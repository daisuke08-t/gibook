Rails.application.routes.draw do
  
  get 'topics/new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  root 'home#index'
  
  resources :users
  
  resources :topics
  
  post '/favorites', to: 'favorites#create'
  
  delete '/favorites_delete', to: 'favorites#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
