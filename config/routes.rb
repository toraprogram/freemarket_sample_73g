Rails.application.routes.draw do
  root 'item_up#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :item_up, only: [:index,:new,:create]
end
