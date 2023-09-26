Rails.application.routes.draw do
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  resources :products
  resources :carts, only: [:show] do
    delete 'destroy_all', to: 'cart_items#destroy_all'
  end
  resources :cart_items, only: [:create, :update, :destroy]
  get '/*a', to: 'application#not_found'

end
