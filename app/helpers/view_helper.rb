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

  def menu_item(name = nil, path = '#')
    options = { class: "nav-link mb-0 #{active?(path)}" }
    tag.li(class: 'nav-item me-3') do
      link_to name, path, options
    end
  end
end
