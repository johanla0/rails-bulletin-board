# frozen_string_literal: true

module CategoryRepository
  extend ActiveSupport::Concern

  included do
    scope :sorted_by_slug_asc, -> { order('slug ASC') }
    scope :sorted_by_slug_desc, -> { order('slug DESC') }
  end
end
