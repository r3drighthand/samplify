Rails.application.routes.draw do

  resources :users, only: [:index, :show]
  resources :tracks, only: [:show]
  resources :samplers, only: [:new, :update]
  # post "/samplers" => "samplers#create", as: "create_sampler"
  root "users#index"

  get "/auth/spotify/callback", to: 'users#spotify'

  delete "/logout", to: "sessions#destroy", as: :logout

end
