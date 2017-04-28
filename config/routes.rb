Rails.application.routes.draw do

  post 'pay2go/return'
  post 'pay2go/notify'
  
  get "/react" => "welcome#react"
  get "/vue" => "welcome#vue"

  resources :products do
    member do
      post :add_to_cart
      post :remove
    end
  end

  resources :orders do
    member do
       post :checkout_pay2go
    end
  end

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
