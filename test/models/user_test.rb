# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  admin      :boolean
#  email      :string
#  name       :string
#  nickname   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'valid user' do
    user = users(:john)

    assert { user.valid? }
  end
end
