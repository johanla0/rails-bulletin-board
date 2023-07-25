# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  # NOTE: This serves as sessions#create according to the omniauth docs
  def callback
    user_info = request.env['omniauth.auth'][:info]
    name = user_info.fetch(:name)
    email = user_info.fetch(:email, '').downcase
    user = User.find_by(email:)
    if user
      sign_in user
      f :success, redirect_back: true, redirect: user_path(user)
    else
      new_user = User.create(name:, email:)
      sign_in new_user
      f :success, redirect_back: true, redirect: user_path(new_user)
    end
  end

  def destroy
    reset_session
    f :success, redirect: root_path, status: :see_other
  end
end
