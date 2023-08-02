# frozen_string_literal: true

class CategoryForm < Category
  include ActiveFormModel

  permit :name, :slug

  validates :name, presence: true
end
