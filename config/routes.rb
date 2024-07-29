Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :merchant, only: [:show, :index] do
    resources :items, only: [:index]#, controller: :specify joins controller 
    resources :invoices, only: [:index]#, controller: :specify joins controller
  end

  # get "/merchants/:id/dashboard", to: "merchants#dashboard"
  # get "/merchants/:id/items", to: "items#index"
  # get "/merchants/:id/invoices", to: "invoices#index"

  namespace :admin do
    resources :merchant, only: [:index]
    resources :invoices, only: [:show]
    resources :merchants, only: [:show, :edit, :update, :index, :create, :new] do
    end
  end
end  
