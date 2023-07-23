# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery

  include AuthHelper
  include Flash
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:error] = t('not_authorized')
    redirect_to request.referer || root_path
  end
end
