# frozen_string_literal: true

class Web::UsersController < Web::ApplicationController
  before_action :authenticate_user

  def show
    authorize(current_user)

    @q = current_user.bulletins.ransack(params[:q])
    @q.sorts = 'updated_at asc' if @q.sorts.empty?
    @bulletins = @q.result(distinct: true).page(params[:page]).includes(image_attachment: :blob)
  end
end
