Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :admins
  devise_for :users


  resources :users
  resources :personal_messages, only: [:new, :create]
  resources :conversations, only: [:index, :show]

  namespace :admin do
    resources :users
    root 'users#index'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'base#index'
end
