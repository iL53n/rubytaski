Rails.application.routes.draw do
  root to: 'application#index'

  devise_for :users

  resources :tasks, only: :index
  resources :stars , only: %i[create update destroy]
end
