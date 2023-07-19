# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = 'https://aa42d3759ef64c8e8f22b2c755a3b48e@o4505335392567296.ingest.sentry.io/4505556377272320'
  config.breadcrumbs_logger = %i[active_support_logger http_logger]
  config.enabled_environments = %w[production]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |_context|
    true
  end
end
