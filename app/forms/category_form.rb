# frozen_string_literal: true

class CategoryForm < Category
  include ActiveFormModel

  permit :name, :slug

  validates_length_of :name, maximum: 50

  def slug=(value)
    super(value.strip.downcase)
  end
end
