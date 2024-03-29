Rails.application.routes.draw do

  root :to => redirect("/usuarios/sign_in")

  devise_for :usuarios, :skip => :registrations

  as :usuario do
    get 'usuarios/edit' => 'registrations#edit', :as => 'edit_usuario_registration'
    put 'usuarios' => 'registrations#update', :as => 'usuario_registration'
  end

  resources :usuarios
  resources :animals
end
