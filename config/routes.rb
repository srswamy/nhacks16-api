Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  namespace :api, :defaults => { :format => :json } do
  	namespace :v1 do
		resources :users do
      collection do
          get 'books/owner', to: 'users_books#get_book_owner'
          get 'books/info', to: 'users_books#get_info'
      end

      get 'lent_books', to: 'users#get_lent_books'
      get 'borrowed', to: 'users#borrowed'
			resources :schools
			resources :books do
        put 'updateStatus', to: 'users_books#update_status'
        put 'updateSent', to: 'users_books#update_sent'
        put 'updateReturn', to: 'users_books#update_sent'
        put 'updateBookAvailability', to: 'users_books#update_book_availability'
        collection do
          post 'rent', to: 'users_books#rent_this_book'
        end
      end
		end
		resources :books, except: :show do 
			collection do
        get 'available', to: 'books#get_available_books'
      end
      resources :categories
    end
	end
  end
  

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
