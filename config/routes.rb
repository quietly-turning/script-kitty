Rails.application.routes.draw do

  root :to => "home#index"

  resources :lessons, only: [:show] do
	  resources :exercises, only: [:index, :show]
  end

  resources :queries, except: [:edit, :destroy, :update]

  resources :websites, only: [:index]
  resources :schools, only: [:index]
  resources :locales, only: [:index]

  devise_for :users, controllers: { registrations: "registrations" }

  #######################################################
  # admin
  resources :admin, only: [:index]

  # admin page(s) for managing users
  get 'admin/users' => 'admin#users', as: :admin_users
  get 'admin/users/:id/edit' => "admin#edit_user",  as: :admin_edit_user
  patch 'admin/users/:id' => "admin#update_user", as: :admin_update_user
  # admin pages(s) for managing queries
  get 'admin/queries' => 'admin#queries', as: :admin_queries

  #######################################################
  # educator
  resources :educator, only: [:index]

  get 'educator/exercises' => 'educator#exercises', as: :educator_exercises
  get 'educator/lessons' => 'educator#lessons', as: :educator_lessons

  #######################################################
  # static pages that are always publicly accessible
  get 'about', to: 'home#about', as: :about
  get 'wrap-up', to: 'home#wrap-up', as: :wrap_up

  # catch non-existent routes
  match '*path', to: redirect('/'), via: :all

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