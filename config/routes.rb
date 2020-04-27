Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  resources :items do
    resources :comments, only: :create
  end
  resources :users, only: :index
  get 'users/:name', controller: 'users', action: 'show'
  get 'users/:name', controller: 'users', action: 'edit'
  resources :card, only: [:new, :index, :create, :destroy]
end
