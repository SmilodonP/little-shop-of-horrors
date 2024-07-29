Rails.application.routes.draw do

  resources :merchants, only: [:show, :index] do
    resources :dashboard, only: [:index]
    resources :items, only: [:index], controller: :merchant_items
    resources :invoices, only: [:index]
  end

  resources :admin, only: [:index]
  namespace :admin do
    resources :merchants, only: [:show, :edit, :update, :index, :create, :new] do
    end
  end

end
