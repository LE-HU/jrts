Rails.application.routes.draw do
  resources :tickets
  devise_for :users, path_prefix: 'auth'
  resources :users, except: [:create]
  resources :events
end
