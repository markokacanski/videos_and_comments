Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  get 'videos/new' => 'videos#new'
  post 'videos/create' => 'videos#create'
  get 'videos/view/:id' => 'videos#view', as: :video_view
  get 'videos/list' => 'videos#list', as: :video_list

  post 'users/login' => 'users#login', as: :login
  get 'users/sign_in' => 'users#sign_in', as: :sign_in
  get 'users/logout' => 'users#logout', as: :logout
  get 'profile/(:username)' => 'users#profile', as: :profile
  post 'profile/save' => 'users#save_profile', as: :save_profile
  get 'edit_profile' => 'users#edit_profile', as: :edit_profile
  get 'register' => 'users#register', as: :register
  post 'new_user' => 'users#new_user', as: :new_user
  post 'playlist/new' => 'playlists#new', as: :new_playlist
  post 'playlist/add_video' => 'playlists#add_video', as: :playlist_add_video
  get 'playlists' => 'playlists#list', as: :playlists
  get 'playlist/:name' => 'playlists#show', as: :playlist
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
