Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root 'home#index'

  resources :complaints
  resources :admins
end
