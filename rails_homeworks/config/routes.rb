Rails.application.routes.draw do
  resources :users
  root 'home#index'

  get 'signup', to: 'users#new',        as: 'signup'
  get 'login',  to: 'sessions#new',     as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :sessions, :users, :petitions
end
