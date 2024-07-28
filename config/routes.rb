Rails.application.routes.draw do

  resources :merchants, only: [:show, :index] do
    resources :items, only: [:index]
    resources :invoices, only: [:index]
  end

  resources :admin, only: [:index]
  namespace :admin do
    resources :invoices, only: [:show]
  end

end
