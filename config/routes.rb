Rails.application.routes.draw do
  
  resources :recipes
  
  mount_devise_token_auth_for 'User', at: 'auth'
end
