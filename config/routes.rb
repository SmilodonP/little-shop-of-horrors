Rails.application.routes.draw do

  resources :merchants, only: [:show, :index] do
    namespace :merchants do 
      resources :items, only: [:index]
    end
    resources :invoices, only: [:index]
  end

  resources :admin, only: [:index]
  namespace :admin do
    resources :merchants, only: [:show, :edit, :update, :index] do
    end
  end

end
