# frozen_string_literal: true

class Web::UsersController < Web::ApplicationController
  def show
    @user = current_user
  end
end
