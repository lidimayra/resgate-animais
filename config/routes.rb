Rails.application.routes.draw do

  root to: 'usuarios#index'

  resources :usuarios
  resources :animals
end
