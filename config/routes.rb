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
end
