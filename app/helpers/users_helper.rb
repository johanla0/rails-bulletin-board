# frozen_string_literal: true

module UsersHelper
  def avatar_for(user, options = {})
    return '' if user.nickname.blank?

    avatar_url = "https://github.com/#{user.nickname}.png?size=100"
    image_tag(avatar_url, alt: user.name, class: 'avatar rounded-circle shadow-4', **options)
  end
end
