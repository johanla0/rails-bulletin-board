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
require 'test_helper'

class BulletinTest < ActiveSupport::TestCase
  test 'valid bulletin' do
    bulletin = bulletins(:one)

    assert { bulletin.valid? }
  end

  test 'invalid bulletin without title' do
    bulletin = Bulletin.create(
      description: Faker::Lorem.paragraph
    )

    assert { bulletin.errors[:title].any? }
  end
end
