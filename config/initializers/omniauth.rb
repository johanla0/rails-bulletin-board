# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer if Rails.env.development?
  provider :github, Rails.application.credentials.dig(:github, :client_id), Rails.application.credentials.dig(:github, :client_secret), scope: 'user'
end
