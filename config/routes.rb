Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/merchants/:id/dashboard", to: "merchants#dashboard"
  get "/merchants/:id/items", to: "items#index"
  get "/merchants/:id/invoices", to: "invoices#index"

  resources :admin, only: [:index]

  namespace :admin do
    resources :merchants, only: [:show, :edit, :update, :index, :create, :new]
    resources :invoices, only: [:show]
    end
  end

  

  