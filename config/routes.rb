Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'



  namespace :account do
    resources :billers, :debtors, :bank_details, :items, :tax_codes, :freight_codes, :invoices, :settings
  end


  match 'account/settings/refresh_content', :via => :post
  match 'account/invoices/refresh_image', :via => :post
  match 'account/invoices/refresh_bank_details', :via => :post
  match 'account/invoices/refresh_biller', :via => :post
  match 'account/invoices/refresh_debtor', :via => :post
  match 'account/invoices/refresh_item', :via => :post
  match 'account/invoices/refresh_tax_code', :via => :post
  match 'account/invoices/refresh_freight_code', :via => :post
  match 'account/logos/get_json_photos', :via => :post


  match ':controller(/:action(/:id))', :via => [:get, :post, :patch]


  mount PdfjsRailsEngine::Engine, :at =>  '/pdf'


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
