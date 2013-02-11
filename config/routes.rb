WeddingPlanner::Application.routes.draw do
  resources :inspirations

  resources :favourite_listings

  resources :todos

  resources :orders

  resources :line_items

  resources :carts
  resources :listings do
    member { post :vote }
  end

  resources :line_items do
   member {put :decrement}
  end

  resources :inspirations do
    collection {post :sort}
  end
  #reference http://railscasts.com/episodes/274-remember-me-reset-password accessed 20/11/2012
  get "store/show"
  get "users/show"
  get "directory/index"
  get "directory/show"
  get "store/show"
  get "store/index"
  get "site/index"
  get "site/faq"
  get "site/coming_soon"

  get 'admin' => 'admin#index'
  get 'store' => 'store#index'
  get 'store_show' => 'store#show'
  get 'directory' => 'directory#index'
  get 'directory_show' => 'directory#show'
  get 'dashboard' => 'users#dashboard'
  get 'vendor_dashboard' => 'users#vendor_dashboard'
  get 'purchase_history' => 'users#purchase_history'
  get 'vendors_dashboard' => 'vendors#dashboard'
  get 'vendors/mylistings' => 'vendors#mylistings'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :users
  resources :vendors
  resources :password_resets
  resources :listings
  resources :sessions
  resources :guests

  resources :products do
    get :who_bought, on: :member
  end

  resources :listings do
    collection { post :search, to: 'directory#index' }
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
  # root :to => 'welcome#index'
  root :to => 'site#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
