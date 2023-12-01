Rails.application.routes.draw do

  resources :billings do
    member do
      get :product_details
    end
  end
  resources :customers do
    member do
      post :send_email
    end
  end
  resources :products
  resources :denominations

  root 'billings#index'
end
