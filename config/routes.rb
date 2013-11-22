TongdaoApi::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  
  ########################################################
  # Counters
  get 'pending_users/count' => 'pending_users#count'
  get 'users/count' => 'users#count'
  # get 'observe_entries/count' => 'observe_entries#count'
  get 'projects/count' => 'projects#count'

  #######################################################
  # Dislike actions
  delete 'projects/:id/likes' => 'likes#destroy'


  resources :users, :only => [:create, :update, :index] do
    resources :projects, :only => [:index]
  end
  resources :projects, :only => [:index, :show, :create, :destroy, :update] do 
    resources :likes, :only => [:create, :index]
  end
  resources :pending_users, :only => [:create, :destroy]
  resources :sessions, :only => [:create, :destroy]
  # resources :observe_entries, :only => [:index, :show, :create, :destroy, :update]
  resources :tags, :only => [:index, :create] 

  root 'application#not_found'

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
