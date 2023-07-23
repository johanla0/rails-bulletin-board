# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer if Rails.env.development?
  provider :github, ENV.fetch('GITHUB_CLIENT_ID', nil), ENV.fetch('GITHUB_CLIENT_SECRET', nil), scope: 'user'
end
