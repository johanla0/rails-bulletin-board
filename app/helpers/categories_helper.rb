# frozen_string_literal: true

module CategoriesHelper
  def all_categories
    Category.sort_by_slug_asc
  end
end
