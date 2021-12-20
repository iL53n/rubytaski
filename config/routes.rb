Rails.application.routes.draw do
  root to: 'application#index'

  devise_for :users

  resources :tasks, only: %i[index create show update destroy]
  resources :goals, only: %i[index create show update destroy]
  resources :stars, only: %i[create destroy]

  # Stat_data
  get '/heatmap_stat', to: 'stars#heatmap_stat'
  get '/stars_stat',   to: 'stars#stars_stat'
  get '/current_stat', to: 'stars#current_stat'

  get '/*path', to: 'application#index', format: false
end
