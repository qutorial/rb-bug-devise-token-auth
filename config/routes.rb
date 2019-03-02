Rails.application.routes.draw do
  
  resources :recipes
  resources :images, only: [:show, :index, :create, :destroy]
  
  mount_devise_token_auth_for 'User', at: 'auth'
end
