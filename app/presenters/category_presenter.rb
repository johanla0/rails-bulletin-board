# frozen_string_literal: true

class CategoryPresenter < SimpleDelegator
  def title
    I18n.t(slug, scope: :'bulletins.slug', default: name)
  end

  delegate :count, to: :bulletins, prefix: true
end
