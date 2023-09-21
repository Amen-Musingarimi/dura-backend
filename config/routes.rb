Rails.application.routes.draw do
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  resources :products
  resources :carts, only: [:show]
  resources :cart_items, only: [:create, :update, :destroy]
  get '/*a', to: 'application#not_found'

end
