Server::Application.routes.draw do
  resources :top_tens

  root :to => "home#index"
  devise_for :users, :developers, :owners, :controllers => {:sessions => "user/sessions", :registrations => "user/registrations"}
  
  match "/about(.:format)" => 'home#about', :as => :about
  match "/developer_page(.:format)" => 'home#developer_page', :as => :developer_page
  match "/chinese_developer_page(.:format)" => 'home#chinese_developer_page', :as => :chinese_developer_page
  match "/tos(.:format)" => 'home#tos', :as => :tos
  match "/faq(.:format)" => 'home#faq', :as => :faq
  match "/quit(.:format)" => 'home#quit', :as => :quit
  match "/download(.:format)" => 'home#download', :as => :sdk_download
  match "/copyright(.:format)" => 'home#copyright', :as => :copyright
  match "/feedback(.:format)" => 'home#feedback', :as => :feedback

  resources :statisticses

  resources :categories


  resources :player_apps

  resources :apps do
    collection do
      get :search, :as => :search
    end
  end

  

  resources :users
  resources :developers do
    resources :apps
    member do
      get :exchange_app, :as => :exchange_app
    end
  end
  resources :players
  resources :owners do
    resources :players
  end

  namespace :api do
    namespace :v1 do
      match "owners/save" => "owners#save", :via => :post
      match "owners/sync" => "owners#sync", :via => :get
      match "owners/iap" => "owners#iap", :via => :post
      resources :score_trackers, :only => [:create]
      resources :time_trackers, :only => [:create]
      resources :apps, :only => [:index]
    end
  end
end
