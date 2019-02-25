Rails.application.routes.draw do
  
  authenticate :user do
    resources :recipes
  end
  
  mount_devise_token_auth_for 'User', at: 'auth'
end
