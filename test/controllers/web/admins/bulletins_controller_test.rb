# frozen_string_literal: true

require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:admin)
  end
  test '#index' do
    sign_in @user

    get admin_bulletins_path
    assert_response :success
  end

  test '#index unauthorized' do
    get admin_bulletins_path
    assert_response :redirect
  end

  test '#archive as admin successful' do
    sign_in @user

    bulletin = bulletins(:two)

    patch archive_admin_bulletin_path(bulletin)

    assert_response :redirect

    bulletin.reload

    assert { bulletin.archived? }
  end

  test '#publish as admin successful' do
    sign_in @user

    bulletin = bulletins(:under_moderation)

    patch publish_admin_bulletin_path(bulletin)

    assert_response :redirect

    bulletin.reload

    assert { bulletin.published? }
  end

  test '#reject as admin successful' do
    sign_in @user

    bulletin = bulletins(:under_moderation)

    patch reject_admin_bulletin_path(bulletin)

    assert_response :redirect

    bulletin.reload

    assert { bulletin.rejected? }
  end
end
