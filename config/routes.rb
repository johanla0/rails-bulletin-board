# frozen_string_literal: true

Rails.application.routes.draw do
  get 'categories/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'web/bulletins#index'

  scope module: :web do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth/logout', to: 'auth#destroy'

    get :profile, to: 'users#show'

    resources :bulletins, only: %i[new create edit update show] do
      member do
        patch :change_state
      end
    end
    resources :categories, only: :show

    get :admin, to: 'admin#index'
    namespace :admin do
      resources :bulletins, only: :index
      resources :categories, only: %i[index new create edit update destroy]
    end
  end
end
