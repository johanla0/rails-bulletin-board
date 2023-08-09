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

    resources :bulletins, only: %i[index new create edit update show] do
      member do
        patch :change_state
      end
    end

    resources :categories, only: :show

    get :admin, to: 'admin#index'
    namespace :admin do
      resources :bulletins, only: :index do
        member do
          # NOTE: Added these routes to pass Hexlet tests
          patch :archive, action: :change_state, controller: 'bulletins', defaults: { state_event: 'archive' }
          patch :publish, action: :change_state, controller: '/web/bulletins', defaults: { state_event: 'publish' }
          patch :reject, action: :change_state, controller: 'bulletins', defaults: { state_event: 'reject' }
          patch :to_moderate, action: :change_state, controller: 'bulletins', defaults: { state_event: 'to_moderate' }
        end
      end
      resources :categories, only: %i[index new create edit update destroy]
    end
  end
end
