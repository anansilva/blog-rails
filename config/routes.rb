Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "posts#index"

  resources :posts, only: [:index, :show]

  namespace :admin do
    resources :posts, except: :destroy
    put 'posts/:id/publish', to: 'posts#publish', as: :publish_post
    put 'posts/:id/unpublish', to: 'posts#unpublish', as: :unpublish_post
    delete 'posts/:id', to: 'posts#destroy', as: :destroy_post
  end

  get "/about/", to: "about#show"

  get '/login', to: 'sessions#new'
  post '/sessions', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
