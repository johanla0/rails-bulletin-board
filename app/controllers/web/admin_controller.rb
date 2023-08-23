# frozen_string_literal: true

class Web::AdminController < Web::ApplicationController
  def index
    authorize([:admin, current_user])

    @q = Bulletin.under_moderation.ransack(params[:q])
    @q.sorts = 'title asc' if @q.sorts.empty?
    @bulletins = @q.result(distinct: true).page(params[:page])
  end
end
