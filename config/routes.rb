Rails.application.routes.draw do
  devise_for :users

  root "puppies#index"

  resources :puppies, only: [:index]

  namespace :admin do
    resources :users, only: [:index]
  end

  namespace :api do
    namespace :v1 do
      resources :puppies, only: [] do
        resources :votes, only: [:create]
      end
    end
  end

  resources :users, only: [] do
    resources :followers, only: [:index]
    resources :followees, only: [:index]
  end
end
