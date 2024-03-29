# -*- encoding : utf-8 -*-
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
  

  resources :users, :only => [:create, :update, :index], :defaults => { format: :json } do
    resources :projects, :only => [:index]

    collection do
      get 'count'
      get 'followers'
      get 'followings'
    end

    member do
      post 'toggle_follow'
      get 'followship'
      get 'followers'
      get 'followings'
      get 'public_activities' => 'public_activities#user_public_activities'
      post 'messages' => 'messages#create'
      get 'conversations' => 'messages#list_conversations'
      get 'messages' => 'messages#list_receipts'
    end
  end

  resources :projects, :defaults => { format: :json } do
    resources :project_comments, :only => [:index, :create]
    resources :project_posts, :only => [:index, :show, :create, :destroy, :update] do
      resources :project_comments, :only => [:index, :create]

      collection do
        get 'show_featured'
      end
    end

    collection do
      get 'count'
    end

    member do
      post 'toggle_like' 
      get 'state_like'
      post 'toggle_membership'
    end
  end

  resources :pending_users, :only => [:create, :destroy], :defaults => { format: :json } do
    collection do
      get 'exist'
    end
  end

  resources :sessions, :only => [:create, :destroy], :defaults => { format: :json }
  resources :tags, :only => [:index], :defaults => { format: :json }
  resources :public_activities, :only => [:index], :defaults => { format: :json } 

  root 'application#not_found', :defaults => { format: :json }

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
