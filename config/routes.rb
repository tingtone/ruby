Server::Application.routes.draw do
  get "most_plays/index"

  get "most_downloads/index"

  devise_for :developers,  :path => 'dev',    :controllers => { :sessions => "dev/sessions", :registrations => "dev/registrations" }
  devise_for :parents,     :path => 'parent', :controllers => { :sessions => "parent/sessions", :registrations => "parent/registrations", :passwords => "parent/passwords" }
  devise_for :forum_users, :path => 'forum',  :controllers => { :sessions => "forum/sessions", :registrations => 'forum/registrations' }
  
  namespace :dev do
    resources :game_applications
    resources :education_applications
    root :to => 'game_applications#index'
  end

  namespace :parent do
    resources :game_applications
    resources :education_applications
    resources :registrations
    resources :analytics do
      member do
        get :game
        get :game_top_5
        get :education
        get :education_top_5
      end
    end
    resources :children do
      member do
        get :game
        get :education
      end
    end
    resources :age_grades
    resources :most_downloads
    resources :most_plays
    #root :to => 'analytics#index'
    root :to => 'game_applications#index'
  end

  namespace :api do
    namespace :v1 do
      resources :parents, :only => [:create]
      resources :parent_sessions, :only => [:create]
      resources :children, :only => [:create, :update]
      resources :time_trackers, :only => [:create]
      resources :score_trackers, :only => [:create]
      resources :passwords, :only => [:create]
      match 'client_applications/kind' => 'client_applications#kind'
    end
  end

  namespace :forum do
    #TODO
    resources :forums do
      resources :topics
    end
    resources :topics do
      resources :posts do
        member do
          post :reply
        end
      end
    end
    
    resources :searches
    
    root :to => "forums#index"
    resources :app_centers, :only => [:index]
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
