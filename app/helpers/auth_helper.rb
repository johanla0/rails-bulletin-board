# frozen_string_literal: true

module AuthHelper
  def sign_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end

  def user_signed_in?
    session[:user_id].present? && current_user.present?
  end

  alias signed_in? user_signed_in?
end
