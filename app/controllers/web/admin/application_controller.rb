# frozen_string_literal: true

class Web::Admin::ApplicationController < Web::ApplicationController
  before_action :require_admin

  private

  def require_admin
    return if current_user&.admin?

    flash[:error] = t('not_authorized')
    redirect_to request.referer || root_path
  end
end
