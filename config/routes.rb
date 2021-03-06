Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  # get 'sessions/new'

  root :to => 'sessions#new'
  get 'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  
  resources :users do
    resources :api_keys , only: [:new, :create, :destroy]
  end
  
  # API routes
  #namespace :api do
   # namespace :v1 do
    #  resources :locations
     # resources :places
    #end
  #end

  # Knock for api authorization
  #mount Knock::Engine => "/api/v1/"
  
  #resources :api_keys, only: [:new, :edit]
  # get 'users/' => 'users#show'
  # get 'users/new'
  # get 'users/:name' => 'users#show'
  # get 'users/:id' => 'users#show'
  
  #get 'users/:id/api_keys/new' => 'api_keys#new'
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :creators, only: [:index, :show, :create, :destroy, :update] do
        resources :places, only: [:index]
      end

      resources :places, only: [:index, :show, :create, :destroy, :update] do
        resources :locations, only: [:index]
        resources :creators, only: [:index]
      end

      resources :locations, only: [:index, :show] do
        resources :places, only: [:index]
      end
    end
  end
  
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
