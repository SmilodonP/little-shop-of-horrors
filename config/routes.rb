Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

get "/merchants/:id/dashboard", to: "merchants#dashboard"
get "/merchants/:id/items", to: "items#index"
get "/merchants/:id/invoices", to: "invoices#index"

end
