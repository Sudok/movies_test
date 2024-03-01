require 'sidekiq/web'

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  resources :movies, only: [:index, :new, :create]
  resources :user_movies, only: [:create, :update]

  post '/movies/import_csv', to: 'movies#import_csv'
  post 'user_movies/batch_import_score_csv', to: 'user_movies#batch_import_score_csv'

  get '/login', to: 'sessions#new'
  delete '/logout', to: 'sessions#destroy'

  root 'sessions#new'

  # UI for sidekiq
  mount Sidekiq::Web => '/sidekiq'
end
