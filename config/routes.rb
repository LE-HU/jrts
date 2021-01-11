Rails.application.routes.draw do
  devise_for :users, path_prefix: 'auth'
  resources :users, except: [:create]
  resources :events do
    resources :tickets
  end
end
