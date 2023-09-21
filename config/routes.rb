Rails.application.routes.draw do
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  resources :products
  get '/*a', to: 'application#not_found'

end
