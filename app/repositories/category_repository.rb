# frozen_string_literal: true

module CategoryRepository
  extend ActiveSupport::Concern

  included do
    scope :sort_by_slug_asc, -> { order('slug ASC') }
    scope :sort_by_slug_desc, -> { order('slug DESC') }
  end
end
