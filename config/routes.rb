Rails.application.routes.draw do
  match "/404", to: "errors#not_found", via: :all
  match "/422", to: "errors#unacceptable", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  scope "(:locale)", locale: /en|pt/ do
    root "home#show"
    get "/home/", to: "home#show"
    get "/about/", to: "about#show"


    resources :posts, only: [:index, :show]
    get 'posts/:id/share/:social_media', to: 'posts#share', as: :share_post

    namespace :admin do
      mount RailsEventStore::Browser => '/res'

      resources :posts, except: %i[new destroy edit]
      resources :analytics, only: :index
      get 'cms/write', to: 'posts#new', as: :new_post
      put 'posts/:id/publish', to: 'posts#publish', as: :publish_post
      get 'posts/:id/edit', to: 'posts#edit', as: :edit_post
      put 'posts/:id/unpublish', to: 'posts#unpublish', as: :unpublish_post
      delete 'posts/:id', to: 'posts#destroy', as: :destroy_post

      get '/login', to: 'sessions#new'
      post '/sessions', to: 'sessions#create'
      delete '/logout', to: 'sessions#destroy'
    end
  end

  get '/sitemap.xml.gz', to: redirect("https://#{Rails.application.credentials.dig(:aws, :prod, :sitemap_bucket)}.s3.#{Rails.application.credentials.dig(:aws, :region)}.amazonaws.com/sitemap.xml.gz")
end
