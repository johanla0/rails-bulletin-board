# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
  end
  test '#show' do
    get user_path(@user)
    assert_response :success
  end
end
