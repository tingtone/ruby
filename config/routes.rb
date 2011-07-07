Server::Application.routes.draw do
  root :to => "home#index"
  match "/about(.:format)" => 'home#about', :as => :about
  
  resources :statisticses
  
  resources :categories

  resources :time_trackers

  resources :score_trackers

  resources :player_apps

  resources :apps

  resources :players

  resources :users

  
end
