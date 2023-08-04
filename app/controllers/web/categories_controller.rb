# frozen_string_literal: true

class Web::CategoriesController < Web::ApplicationController
  def show
    @category = Category.find(params[:id]).decorate
    @bulletins = @category.bulletins.published
  end
end
