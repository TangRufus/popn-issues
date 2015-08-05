require 'sidekiq/web'
require 'sidetiq/web'

Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :edit, :update]

  resources :issues, only: [:index, :new, :create, :show] do
    member do
      patch 'change_status', to: 'issues#change_status'
      resources :comments, only: [:create]
    end
  end

  authenticated :user do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :wikis, only: [:index, :new, :create, :show, :edit, :update]

  root 'issues#index'
end
