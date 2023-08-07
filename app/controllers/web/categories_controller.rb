# frozen_string_literal: true

class Web::CategoriesController < Web::ApplicationController
  def show
    @category = Category.find(params[:id]).decorate

    @q = @category.bulletins.published.ransack(params[:q])
    @q.sorts = 'updated_at asc' if @q.sorts.empty?
    @bulletins = @q.result(distinct: true).page(params[:page])
  end
end
