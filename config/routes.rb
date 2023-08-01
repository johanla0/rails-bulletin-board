# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'web/bulletins#index'

  scope module: :web do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    get 'auth/logout', to: 'auth#destroy'

    resources :users, only: :show
    resources :bulletins, except: :index
    resources :categories, only: :show

    namespace :admin do
      root 'welcome#index'
    end
  end
end
