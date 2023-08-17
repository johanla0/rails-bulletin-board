# frozen_string_literal: true

class Web::UsersController < Web::ApplicationController
  before_action :authenticate_user

  def show
    @user = current_user
    authorize(@user)

    @q = @user.bulletins.ransack(params[:q])
    @q.sorts = 'updated_at asc' if @q.sorts.empty?
    @bulletins = @q.result(distinct: true).page(params[:page])
  end
end
