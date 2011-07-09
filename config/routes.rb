Server::Application.routes.draw do
  resources :top_tens

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

  namespace :api do
    namespace :v1 do
      match "owners/save" => "owners#save", :via => :post
      match "owners/sync" => "owners#sync", :via => :get
      resources :score_trackers, :only => [:create]
      resources :time_trackers, :only => [:create]
    end
  end
end
