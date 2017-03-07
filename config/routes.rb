Rails.application.routes.draw do
  devise_for :users
  root "home#show"

  namespace :admin do
    resources :users, only: [:index]
  end
end
