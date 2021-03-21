Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/home/", to: "home#show"
  root "home#show"

  match "/404", to: "errors#not_found", via: :all
  match "/422", to: "errors#unacceptable", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

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

  get "/about/", to: "about#show"

  get '/sitemap.xml.gz', to: redirect("https://#{Rails.application.credentials.dig(:aws, :prod, :sitemap_bucket)}.s3.#{Rails.application.credentials.dig(:aws, :region)}.amazonaws.com/sitemap.xml.gz")

  get '/feed.xml', to: "posts#rss_feed", as: :rss_feed, constraints: { format: 'rss' }
end
