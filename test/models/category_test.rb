# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id              :integer          not null, primary key
#  bulletins_count :integer          default(0)
#  name            :string           not null
#  slug            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test 'valid category' do
    category = categories(:one)

    assert { category.valid? }
  end
end
