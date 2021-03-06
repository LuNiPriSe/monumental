Monumental::Application.routes.draw do
  devise_for :users

  root 'collections#index'
  
  resources :collections
  resources :monuments
  resources :categories
  resources :pictures
  get 'monuments/new(/:collection_id)' => "monuments#new", as: "add_monument"
  get 'monuments/new/:id/step/:step' => "monuments#new", as: "new_step_monument"
  get 'monuments/edit/:id/step/:step' => "monuments#edit", as: "edit_step_monument"
  post 'monuments/finish/:id' => "monuments#finish", as: "finish_monument"
  post 'monuments/add_picture/:id' => "monuments#add_picture", as: "add_picture"
  
  post 'monuments/change_public_state/:id' => "monuments#change_public_state", as: "change_public_state"
  post 'monuments/change_approval_state/:id' => "monuments#change_aproval_state", as: "change_aproval_state"  # typo in model etc. :-(
  
  get 'stream(/:search)' => "stream#index", as: "monuments_stream"
  get 'coverflow(/:search)' => "stream#orbit", as: "monuments_orbit"
  get 'approve' => "stream#aprove", as: "monuments_aprove_stream"
  
  
  
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

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
