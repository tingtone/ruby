Server::Application.routes.draw do
  resources :top_tens

  root :to => "home#index"
  devise_for :users
  
  match "/about(.:format)" => 'home#about', :as => :about
  match "/developer(.:format)" => 'home#developer', :as => :developer

  resources :statisticses

  resources :categories

  resources :time_trackers

  resources :score_trackers

  resources :player_apps

  resources :apps

  resources :players

  resources :users

  namespace :api do
    namespace :v1 do
      match "owners/save" => "owners#save", :via => :post
      match "owners/sync" => "owners#sync", :via => :get
      resources :score_trackers, :only => [:create]
      resources :time_trackers, :only => [:create]
    end
  end
end
