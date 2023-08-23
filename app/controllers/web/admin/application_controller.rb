# frozen_string_literal: true

class Web::Admin::ApplicationController < Web::ApplicationController
  before_action :authorize

  private

  def authorize(record = current_user, query = nil)
    if record.present?
      super([:admin, record], query)
      return
    end

    flash[:error] = t('not_authorized')
    redirect_to request.referer || root_path
  end
end
