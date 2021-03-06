Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener"

  # admin part
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # Tag filtering
  get 'blogs/:id/filter/:tag_name', to: 'blogs#show', as: :tag_filter

  # blog of currently signed user
  get 'myblog' => 'blogs#myblog'

  # edit settings of blog of currently signed user
  get 'myblogsettings' => 'blogs#editmyblog'

  # create new post on blog of currently signed user
  get 'new_post_on_my_blog' => 'blogs#new_post_on_my_blog'


  #blogs
  resources :blogs, shallow: true do
    # create blog posts
    resources :posts, only: [:new, :create, :edit, :update, :destroy], shallow: true do
    end
  end

  # create post comments
  resources :comments, only: [:create, :destroy] do
    member do
      put "like", to: "comments#upvote"
      put "dislike", to: "comments#downvote"
      put "approve", to: "comments#approve"
    end
  end

  devise_for :users

  root 'blogs#index' # relative to views forlder

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
  #     #     resources :sales do
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
