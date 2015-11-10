Rails.application.routes.draw do

  devise_for :usuarios
  root to: 'usuarios#index'

  resources :usuarios
  resources :animals
end
