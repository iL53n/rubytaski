Rails.application.routes.draw do
  root to: 'application#index'

  devise_for :users

  resources :tasks, only: %i[index create destroy]
  resources :stars , only: %i[create update destroy]
end
