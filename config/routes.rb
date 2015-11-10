Rails.application.routes.draw do

  devise_for :usuarios

  devise_scope :usuario do
    root to: 'usuarios#index'
  end

  resources :usuarios
  resources :animals
end
