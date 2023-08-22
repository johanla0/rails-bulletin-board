# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  # NOTE: This serves as sessions#create according to the omniauth docs
  def callback
    user_info = request.env['omniauth.auth'][:info]
    email = user_info.fetch(:email, '').downcase
    user = User.find_or_initialize_by(email:)
    user.name = user_info.fetch(:name)
    user.nickname = user_info.fetch(:nickname, '')
    if user.save
      sign_in user
      f :success, redirect_back: true, redirect: profile_path
    else
      f :error, redirect_back: true, redirect: root_path
    end
  end

  def destroy
    reset_session
    f :success, redirect: root_path, status: :see_other
  end
end
