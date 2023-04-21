Rails.application.routes.draw do
  root 'sessions#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'home', to: 'users#home'
  get 'forgot_password', to: 'users#forgot_password'
  post 'reset_password', to: 'users#reset_password'
 
  resources :users
  resources :projects
end
