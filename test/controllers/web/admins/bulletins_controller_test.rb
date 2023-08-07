# frozen_string_literal: true

require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get admin_bulletins_path
    assert_response :success
  end
end
