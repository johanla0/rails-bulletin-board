# frozen_string_literal: true

module Flash
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def f(key, options = {})
    scope = :flash
    errors = options[:errors]
    redirect_path = options[:redirect]
    msg = t(".#{key}", scope:, default: key, errors:)
    status = options[:status].presence || :ok

    # NOTE: color logging
    Rails.logger.debug(Term::ANSIColor.green("flash: #{msg}"))

    type = options[:type] || key
    if options[:now] || options[:turbo_stream]
      flash.now[type] = msg
    else
      flash[type] = msg
    end

    if redirect_path
      if options[:redirect_back].present?
        redirect_back(fallback_location: redirect_path)
      else
        redirect_to redirect_path
      end
    elsif options[:render]
      render options[:render], status:
    elsif options[:turbo_stream]
      t_stream = Array.wrap(options[:turbo_stream])
      t_stream << turbo_stream.update('flash', partial: 'layouts/shared/flash')
      render turbo_stream: t_stream, status:
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity
end
