Rails.application.routes.draw do
  resources :parks

  resources :parkings
  resources :reports do
    get "delete"
  end
  resources :members do
    get "delete"
    get "look"
  end
  resources :try_codes, only: [:new, :create, :index]
  resources :billings, only:[:new, :create, :index, :destroy, :show, :durate, :give_time] do
    # collection do
#       get 'current'
#     end
    
    member do
      patch 'stop'
    end
  end

  match '/angkat_portal' => 'billings#angkat_portal', via: :get
  match '/turunkan_portal' => 'billings#turunkan_portal', via: :get
  match '/give_time' => 'billings#give_time', via: :get
  match '/durate' => 'billings#durate', via: :get
  match '/buat_karcis' => 'billings#buat_karcis', via: :get
  
  match '/angkat_portal_parkir1' => 'parks#angkat_portal_parkir1', via: :get
  match '/turunkan_portal_parkir1' => 'parks#turunkan_portal_parkir1', via: :get
  
  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  root 'billings#new'
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
