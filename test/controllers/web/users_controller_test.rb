# frozen_string_literal: true

require 'test_helper'

class Web::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
  end
  test '#show' do
    get profile_path
    assert_response :success
  end
end
