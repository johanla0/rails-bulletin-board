# frozen_string_literal: true

class Web::CategoriesController < Web::ApplicationController
  def show
    @category = Category.find(params[:id]).decorate

    scope = current_user&.admin? ? @category.bulletins : @category.bulletins.published
    @q = scope.ransack(params[:q])

    @q.sorts = 'updated_at asc' if @q.sorts.empty?
    @bulletins = @q.result(distinct: true).page(params[:page]).includes(image_attachment: :blob)
  end
end
