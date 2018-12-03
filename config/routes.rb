Rails.application.routes.draw do



  resources :payments, only: [:new, :create] do
    delete '/cancel_subscription_plan' => "payments#cancel_subscription_plan"
  end

  resources :job_portals do
    collection do
      get '/vacancies' => "job_portals#vacancies"
    end
  end

  namespace :admin do
    resources :companies
    resources :job_portals
    resources :transactions
    put '/transactions/approve_transaction/:id' => "transactions#approve_transaction"
    put '/job_portals/approve_job/:id' => "job_portals#approve_job"
    resources :candidates do
      member do
        post 'upload_avatar'
        get 'get_avatar'
        delete 'delete_avatar'
      end
    end
    put '/candidates/approve_user/:id' => "candidates#approve_user"
    resources :sites
    resources :sectors
  end
  get '/dashboard' => "dashboard#index", as: :user_root

  require 'sidekiq/web'
  mount Sidekiq::Web => "/sidekiq"

  resources :sites
  resources :feeds

  devise_for :users, :controllers => {:sessions => "sessions", :registrations => 'registrations'}
  get '/news_sites' => "news#news_sites", format: 'json'

  resources :news, except: [:destroy, :create, :new, :edit, :show, :update] do
    collection do
      get ':site_id/entries'  => 'news#news_entries'
      get '/first_site' => "news#first_site"
      get '/latest_news' => "news#latest_news"
      get '/news_filters' => "news#news_filters"
    end
  end
  resources :candidates, except: [:destroy, :edit, :show, :update] do
    member do
      get '/people_detail' => "candidates#people_detail"
    end
    collection do
      get '/people_filters' => "candidates#people_filters"
      get '/people_list' => "candidates#people_list"
    end
  end
  resources :organization, except: [:destroy, :create, :new, :edit, :show, :update] do
    member do
      get '/ma_transaction' => "organization#ma_transaction"
      get '/advisor_transaction' => "organization#advisor_transaction"
      get '/organization_detail' => "organization#organization_detail"
    end
    collection do
      get '/organization_filters' => "organization#organization_filters"
      get '/organization_list' => "organization#organization_list"
      get '/organization_sectors'  => "organization#organization_sectors"
    end
  end

  resources :transactions, except: [:destroy, :show] do
    collection do
      get '/transaction_filters' => "transactions#transaction_filters"
      get '/transaction_list' => "transactions#transaction_list"
      get '/recent_deals' => "transactions#recent_deals"
    end
  end

  get '/pricing' => "static_pages#price"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

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

  # You can have the root of your site routed with "root"
  root "static_pages#index"
end
