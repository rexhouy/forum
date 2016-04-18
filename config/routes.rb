Rails.application.routes.draw do

	get "history_back" => "history_back#index"

        devise_for :users, controllers: {
                sessions: "auth/sessions",
                confirmations: "auth/sessions",
                omniauth: "auth/omniauth",
                passwords: "auth/passwords",
                registrations: "auth/registrations",
                unlocks: "auth/unlocks"
        }
        get "users/captcha" => "auth/captcha#index"
	post "redactor_rails/pictures" => "images#create"
	post "topics/:id/like" => "topics#like"
	get "topics/search" => "topics#search"

	post "image" => "images#create"

	resources :topics do
		resources :posts
	end
	post "topics/:tid/enroll" => "enrolls#create"
	get "topics/:id/enroll" => "enrolls#index"
	get "topics/:id/new_enroll" => "enrolls#new"
	get "enrolls/:id" => "enrolls#show"
	post "enrolls/:id/confirm" => "enrolls#confirm"

	get "customer_sign_in" => "users#customer_sign_in"
	post "customer_sign_in" => "users#customer_sign_in_check"

	get "activities" => "topics#activities"

        resources :categories
	resources :users
	get "user/enrolls" => "users#enrolls"

	# Payment
	get 'payment/alipay/redirect' => 'payments#alipay_redirect'
	# Payment callback
	get 'payment/alipay/front_notify' => 'payments#alipay_front_notify'
	post 'payment/alipay/notify' => 'payments#alipay_notify'

	get "chat/:enroll_id" => "chat#index"
	post "chat/:topic_id" => "chat#create"
	get "chat/:topic_id/latest" => "chat#latest"
	get "chat/:topic_id/history" => "chat#history"

	post "images" => "images#create"
        # The priority is based upon order of creation: first created -> highest priority.
        # See how all your routes lay out with "rake routes".

        # You can have the root of your site routed with "root"
        root "topics#activities"

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
