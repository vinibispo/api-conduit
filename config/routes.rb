# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    get '/user', to: 'users/sessions#show', as: 'user'
    namespace :users do
      post 'login', to: 'sessions#create', as: 'login'
      post '/', to: 'registrations#create', as: 'register'
    end
  end
end
