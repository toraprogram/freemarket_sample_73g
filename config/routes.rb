Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  resources :items do
    get '/buycheck', controller: 'items', action: 'buycheck'
    #Ajaxで動くアクションのルートを作成
    collection do
      get 'category' 
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end
  resources :users, only: :index
  get 'users/:name', controller: 'users', action: 'show'
  get 'users/:name', controller: 'users', action: 'edit'
  resources :card, only: [:new, :index, :create, :destroy]

end
