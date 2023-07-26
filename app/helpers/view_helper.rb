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
end
