# frozen_string_literal: true

# == Schema Information
#
# Table name: bulletins
#
#  id          :integer          not null, primary key
#  description :text             not null
#  state       :string
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer          not null
#  user_id     :integer          not null
#
# Indexes
#
#  index_bulletins_on_category_id  (category_id)
#  index_bulletins_on_user_id      (user_id)
#
# Foreign Keys
#
#  category_id  (category_id => categories.id)
#  user_id      (user_id => users.id)
#
class Bulletin < ApplicationRecord
  include AASM

  IMAGE_CONTENT_TYPES = ['image/png', 'image/jpg', 'image/jpeg'].freeze

  validates :image, content_type: IMAGE_CONTENT_TYPES,
                    size: { less_than_or_equal_to: 5.megabytes }

  belongs_to :user
  belongs_to :category, counter_cache: true
  has_one_attached :image

  aasm column: 'state' do
    state :draft, initial: true
    state :under_moderation, :published, :rejected, :archived

    event :to_moderate do
      transitions from: :draft, to: :under_moderation
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :archive do
      transitions from: %i[draft under_moderation published rejected], to: :archived
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[category_id created_at description title updated_at]
  end
end
