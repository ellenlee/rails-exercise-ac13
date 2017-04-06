Rails.application.routes.draw do

  resources :products

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

  root "products#index"
end
