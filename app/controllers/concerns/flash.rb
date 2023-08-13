# frozen_string_literal: true

module Flash
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def f(key, options = {})
    scope = :flash
    controller = self.class
    errors = options[:errors]
    redirect_path = options[:redirect]
    keys = build_path(key, controller, params[:action])
    msg = I18n.t(keys.shift, scope:, default: keys, errors:)
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
      render render_template, status:
    elsif options[:turbo_stream]
      t_stream = Array.wrap(options[:turbo_stream])
      t_stream << turbo_stream.update('flash', partial: 'layouts/shared/flash')
      render turbo_stream: t_stream, status:
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity

  private

  def build_path(type, controller, action)
    keys = []
    lookup_controller = controller
    lookup_action = action

    while lookup_controller.superclass.name != 'ActionController::Base'
      lookup_key = []
      lookup_key << lookup_controller.controller_path.tr('/', '.')
      lookup_key << lookup_action
      lookup_key << type

      keys << lookup_key.join('.').to_sym

      lookup_controller = lookup_controller.superclass
      lookup_action = :base
    end

    keys
  end
end
