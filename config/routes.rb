Rails.application.routes.draw do
  devise_for :users
  root 'top#index'
  resources :items do
    resources :comments, only: :create
  end

  resources :card, only: [:new, :index, :create, :destroy]
end
