Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  resources :items do
    get '/buycheck', controller: 'items', action: 'buycheck'
    post '/payment', controller: 'items', action: 'payment'
    #Ajaxで動くアクションのルートを作成
    collection do
      get 'category' 
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'search'
    end
  end
  resources :users, only: :index
  get 'users/:name', controller: 'users', action: 'show'
  get 'users/:name', controller: 'users', action: 'edit'
  
  resources :card, only: [:index, :new, :show, :destroy] do
    collection do
      post 'show', to: 'card#show'
      post 'pay', to: 'card#pay'
    end
  end
  resources :categories, only: :index

end
