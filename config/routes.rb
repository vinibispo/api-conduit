# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    get '/user', to: 'users/sessions#show', as: 'user'
    put '/user', to: 'users/sessions#update', as: 'update_user'
    namespace :users do
      post 'login', to: 'sessions#create', as: 'login'
      post '/', to: 'registrations#create', as: 'register'
    end

    resources :articles, only: %i[index]
  end
end
