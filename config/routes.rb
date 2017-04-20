Rails.application.routes.draw do

  get "/react" => "welcome#react"
  
  resources :products do
    member do
      post :add_to_cart
      post :remove
    end
  end

  resources :orders

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :ubikes

  resources :topics do
    member do
      post :like
      post :unlike
    end

    #resources :likes
  end

  namespace :admin do
    resources :products # Admin::ProductsController
  end

  root "products#index"
end
