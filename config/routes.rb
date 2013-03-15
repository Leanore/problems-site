CProject::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  get "tags/index"
  get "tags/tag"

  mount Ckeditor::Engine => '/ckeditor'

  ActiveAdmin.routes(self)

  #devise_for :admin_users, ActiveAdmin::Devise.config, ActiveAdmin::Devise.config

  resources :charts
  resources :problems

  resources :problems do
    member do
      put :solve
    end
  end

  resources :tags
  resources :tags do
    member do
      get :tag
    end
  end

  authenticated :user do
    root :to => 'home#index'       # to change later maybe OR  after_sign_in_path_for and after_sign_out_path_for
    get "services/add"
  end
  root :to => 'home#index'

  devise_for :users do
    get "/users/sign_out" => "devise/sessions#destroy", :as => :destroy_user_session
  end
  resources :users, :only => [:show, :index, :edit, :posted_problems, :solved_problems]
  resources :users do
    member do
      put :edit
      get :posted_problems
      get :solved_problems
    end
  end

  match '/auth/:service/callback' => 'services#create'
  resources :services, :only => [:index, :create, :destroy]





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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
