Rails.application.routes.draw do

  resources :merchants, only: [:show, :index] do
    resources :dashboard, only: [:index]
    resources :items, only: [:index, :edit, :update, :show, :create, :new], controller: :merchant_items
    resources :invoices, only: [:index, :show], controller: :merchant_invoices
  end

  resources :admin, only: [:index]

  namespace :admin do
    resources :merchants, only: [:show, :edit, :update, :index, :create, :new]
    resources :invoices, only: [:show, :index]
  end
end

