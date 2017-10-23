Rails.application.routes.draw do

  resources :users, only: [:index, :show]
  resources :tracks, only: [:show, :update]
  resources :samplers, only: [:new, :show, :update]

  root "users#index"

  get "/auth/spotify/callback", to: 'users#spotify'

  delete "/logout", to: "sessions#destroy", as: :logout

  get "/samplers", to: "samplers#create", as: :samplify
end
