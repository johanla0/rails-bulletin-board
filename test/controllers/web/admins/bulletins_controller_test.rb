# frozen_string_literal: true

require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  test '#index' do
    user = users(:admin)
    sign_in user

    get admin_bulletins_path
    assert_response :success
  end

  test '#index unauthorized' do
    get admin_bulletins_path
    assert_response :redirect
  end
end
