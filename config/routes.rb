Rails.application.routes.draw do
  devise_for :users, path_prefix: 'auth'
  resources :users, except: [:create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
