# frozen_string_literal: true

module AuthHelper
  def self.included(controller)
    controller.helper_method %i[sign_in current_user signed_in?]
  end

  def sign_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end

  def signed_in?
    session[:user_id].present? && current_user.present?
  end
end
