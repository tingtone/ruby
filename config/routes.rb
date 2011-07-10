Server::Application.routes.draw do
  resources :top_tens

  root :to => "home#index"
  devise_for :users, :developers, :owners
  
  match "/about(.:format)" => 'home#about', :as => :about
  match "/developer(.:format)" => 'home#developer', :as => :developer
  match "/tos(.:format)" => 'home#tos', :as => :tos
  match "/faq(.:format)" => 'home#faq', :as => :faq
  match "/quit(.:format)" => 'home#quit', :as => :quit

  resources :statisticses

  resources :categories

  resources :time_trackers

  resources :score_trackers

  resources :player_apps

  resources :apps do
    collection do
      get :search, :as => :search
    end
  end

  

  resources :users
  resources :developers do
    resources :apps
  end
  resources :players
  resources :owners do
    resources :players
  end

  namespace :api do
    namespace :v1 do
      match "owners/save" => "owners#save", :via => :post
      match "owners/sync" => "owners#sync", :via => :get
      resources :score_trackers, :only => [:create]
      resources :time_trackers, :only => [:create]
      resources :apps, :only => [:index]
    end
  end
end
