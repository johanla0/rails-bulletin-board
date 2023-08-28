# frozen_string_literal: true

class Web::ApplicationController < ApplicationController
  include AuthHelper
  include Flash
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def authenticate_user
    return if current_user.present?

    flash[:error] = t('not_authorized')
    redirect_to request.referer || root_path
  end

  private

  def user_not_authorized
    flash[:error] = t('not_authorized')
    redirect_to request.referer || root_path
  end
end
