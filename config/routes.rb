Rails.application.routes.draw do
  devise_for :users, path_prefix: 'auth'
  namespace :api do
    namespace :v1 do
      resources :users, except: [:create]
      resources :events do
        resources :tickets, except: [:update]
      end
    end
  end
end
