# frozen_string_literal: true

module ViewHelper
  private

  FLASH_CLASSES = {
    error: 'danger',
    alert: 'danger',
    warning: 'warning',
    info: 'info',
    success: 'success'
  }.freeze

  def flash_class(flash_name)
    FLASH_CLASSES[flash_name.to_sym]
  end

  def active?(path)
    without_query_params_path = path.split('?').first
    'active' if without_query_params_path == request.path
  end

  def menu_item(name = nil, path = '#', *args)
    args_options = args.extract_options!
    options = { class: "nav-link mb-0 #{active?(path)}" }.merge args_options
    tag.li(class: 'nav-item me-3') do
      link_to name, path, options
    end
  end

  def link_to_bulletin_action(bulletin, action, *args)
    name = I18n.t(action, scope: 'bulletins.actions')
    args_options = args.extract_options!
    options = { data: { turbo_method: :patch } }.merge args_options

    if current_user.admin?
      return '' if !policy([:admin, bulletin]).send("#{action}?")

      path = polymorphic_path([action, :admin, bulletin])
    else
      return '' if !policy(bulletin).send("#{action}?")

      path = polymorphic_path([action, bulletin])
    end

    link_to name, path, options
  end
end
