Rails.application.routes.draw do
  root to: 'application#index'

  devise_for :users

  resources :tasks, only: %i[index create show update destroy]
  resources :goals, only: %i[index create show update destroy]
  resources :stars, only: %i[create destroy]

  get '/statistics', to: 'stars#statistics'

  get '/*path', to: 'application#index', format: false
end
