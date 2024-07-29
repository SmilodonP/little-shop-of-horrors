Rails.application.routes.draw do

  resources :merchants, only: [:show, :index] do
    resources :dashboard, only: [:index]
    resources :items, only: [:index]
    resources :invoices, only: [:index]
  end

  resources :admin, only: [:index]
  namespace :admin do
    resources :merchants, only: [:show, :edit, :update, :index, :create, :new]
    resources :invoices, only: [:show]
    end
  end

end
