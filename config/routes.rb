Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'application#index'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :users do
    get :me, on: :collection
  end

  constraints format: :json do
    resources :tasks, only: %i[index create show update destroy] do
      patch :update_order, to: 'tasks#update_order', on: :collection
      patch :set_state, to: 'tasks#set_state', on: :member
    end

    resources :goals, only: %i[index create show update destroy] do
      patch :set_state, to: 'goals#set_state', on: :member
    end

    resources :stars, only: %i[create destroy]

    # TODO: add set locale in user profile
    get :locale, to: 'application#locale'

    # Stat_data
    # TODO: add scope 'stat'
    get '/heatmap_stat', to: 'stars#heatmap_stat'
    get '/stars_stat',   to: 'stars#stars_stat'
    get '/current_stat', to: 'stars#current_stat'

    resources :statistics, only: :index
  end

  # get '/*path', to: 'application#index', format: false
  get '/*slug', to: 'application#index',
                constraints: ->(request) { !request.fullpath.include?('rails/active_storage') }
end
