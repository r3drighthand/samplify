Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  resources :tracks

  root "playlists#index"

  get "/playlists/show" => "playlists#show"

  get "/playlists/delete" => "playlists#destroy"

  get "/auth/spotify/callback", to: 'users#spotify'

  delete "/logout", to: "sessions#destroy", as: :logout

end
