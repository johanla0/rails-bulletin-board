# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def index
    authorize(Bulletin)

    @q = Bulletin.ransack(params[:q])
    @q.sorts = 'title asc' if @q.sorts.empty?
    @bulletins = @q.result(distinct: true).page(params[:page])
  end
end
