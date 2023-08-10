# frozen_string_literal: true

class Web::CategoriesController < Web::ApplicationController
  def show
    @category = Category.find(params[:id]).decorate
    authorize @category

    @q = if user_signed_in? && current_user.admin?
           @category.bulletins.ransack(params[:q])
         else
           @category.bulletins.published.ransack(params[:q])
         end
    @q.sorts = 'updated_at asc' if @q.sorts.empty?
    @bulletins = @q.result(distinct: true).page(params[:page])
  end
end
