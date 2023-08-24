# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'web/bulletins#index'

  scope module: :web do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth/logout', to: 'auth#destroy'

    resource :profile, only: :show, controller: :users

    resources :bulletins, only: %i[index new create edit update show] do
      member do
        patch :archive
        patch :to_moderate
      end
    end

    resources :categories, only: :show

    namespace :admin do
      resources :admins, path: '', only: :index, controller: :home
      resources :bulletins, only: :index do
        member do
          patch :archive
          patch :publish
          patch :to_moderate
          patch :reject
        end
      end
      resources :categories, only: %i[index new create edit update destroy]
    end
  end
end
