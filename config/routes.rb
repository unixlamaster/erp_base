Foundation::Application.routes.draw do

  match 'contracts/new_wo/' => 'contracts#new_wo',  :via => [:get,:post]
  match 'contracts/add_wo/' => 'contracts#add_wo',  :via => [:get,:post]
  match 'contracts/edit_wo/' => 'contracts#edit_wo',  :via => [:get,:post]
  match 'contracts/update_wo/' => 'contracts#update_wo',  :via => [:get,:post]
  match 'contracts/del_wo/' => 'contracts#del_wo',  :via => [:get,:post]
  resources :contracts


  devise_for :staffs, :except => :create

  match 'staffs/edit_password/' => 'staffs#edit_password', :via => [:get]
  match 'staffs/update_password/' => 'staffs#update_password', :via => [:get,:post,:put]
  resources :staffs

  resources :finances

  resources :storages
  resources :staffobjectjournals


  resources :posts
  resources :task_delegates


  resources :data_files do
    collection { post :upload }
  end

  resources :uploads
#   do
#    collection { post :upload }
#  end

  resources :staff_task_journals

  get 'tasks/change/:id(.:format)', to: 'tasks#change', as: 'task_change'
  post 'tasks/change/:id(.:format)', to: 'tasks#change', as: 'task_change'
  resources :tasks

  resources :workobjects

  resources :map

  root to: "map#index"


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
