Server::Application.routes.draw do
  
  
  resources :categories

  resources :time_trackers

  resources :score_trackers

  resources :player_apps

  resources :apps

  resources :players

  resources :users

  root :to => "home#index"
end
