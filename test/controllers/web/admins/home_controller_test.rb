# frozen_string_literal: true

require 'test_helper'

class AdminsControllerTest < ActionDispatch::IntegrationTest
  test '#index' do
    user = users(:admin)
    sign_in user

    get admin_admins_path
    assert_response :success
  end

  test '#index unauthorized' do
    get admin_admins_path
    assert_response :redirect
  end
end
