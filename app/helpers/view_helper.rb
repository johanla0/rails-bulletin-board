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

  ADMIN_ACTIONS = %i[archive to_moderate publish reject].freeze
  USER_ACTIONS = %i[archive to_moderate].freeze

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
    return '' if !current_user.admin? && USER_ACTIONS.exclude?(action)

    path = if current_user.admin? && ADMIN_ACTIONS.include?(action)
             polymorphic_path([action, :admin, bulletin])
           elsif USER_ACTIONS.include?(action)
             polymorphic_path([action, bulletin])
           else
             '#'
           end
    name = I18n.t(action, scope: 'bulletins.actions')

    args_options = args.extract_options!
    options = { data: { turbo_method: :patch } }.merge args_options

    case action
    when :archive
      link_to name, path, options if bulletin.may_archive?
    when :publish
      link_to name, path, options if bulletin.under_moderation?
    when :reject
      link_to name, path, options if bulletin.may_reject?
    when :to_moderate
      link_to name, path, options if bulletin.may_to_moderate? && !bulletin.published?
    else ''
    end
  end
end
