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
  

  resources :users, :only => [:create, :update, :index] do
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
    end
  end

  resources :projects do
    collection do
      get 'count'
    end

    member do
      post 'toggle_like' 
      get 'state_like'  
    end
  end

  resources :pending_users, :only => [:create, :destroy] do
    collection do
      get 'count'
    end
  end

  resources :sessions, :only => [:create, :destroy]
  resources :tags, :only => [:index] 
  resources :public_activities, :only => [:index]

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
