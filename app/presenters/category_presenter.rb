# frozen_string_literal: true

class CategoryPresenter < SimpleDelegator
  def title
    return I18n.t(slug, scope: :'bulletins.slug', default: name) if slug.present?

    name
  end

  delegate :count, to: :bulletins, prefix: true
end
