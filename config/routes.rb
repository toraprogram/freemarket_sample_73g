Rails.application.routes.draw do
  root 'items#index'
  resources :items do
    resources :comments, only: :create
  end
  
  resources :card, only: [:new, :index, :create, :destroy]
end
