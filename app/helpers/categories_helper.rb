# frozen_string_literal: true

module CategoriesHelper
  def all_categories
    Category.all.map(&:decorate).sort_by(&:title)
  end
end
