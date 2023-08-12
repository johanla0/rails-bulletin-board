# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:one)
    @category = categories(:one)
    @user = users(:john)
  end

  test '#index' do
    get root_path
    assert_response :success
  end

  test '#new' do
    sign_in @user

    get new_bulletin_path
    assert_response :success
  end

  test '#create' do
    sign_in @user

    attrs = {
      image: fixture_file_upload('image_01.png', 'image/png'),
      title: SecureRandom.uuid,
      description: Faker::Lorem.paragraph,
      category_id: @category.id
    }

    post bulletins_path, params: { bulletin: attrs }

    assert_response :redirect

    bulletin = Bulletin.find_by(title: attrs[:title])

    assert { bulletin.present? }
  end

  test '#show' do
    get bulletin_path(@bulletin)
    assert_response :success
  end

  test '#edit' do
    sign_in @user

    get edit_bulletin_path(@bulletin)
    assert_response :success
  end

  test '#update' do
    sign_in @user

    new_attrs = {
      title: SecureRandom.uuid
    }

    patch bulletin_path(@bulletin), params: { bulletin: new_attrs }

    assert_response :redirect

    @bulletin.reload

    assert { @bulletin.title == new_attrs[:title] }
  end

  test '#publish successful' do
    bulletin = bulletins(:under_moderation)
    user = users(:admin)
    sign_in user

    patch publish_bulletin_path(bulletin)

    assert_response :redirect

    bulletin.reload

    assert { bulletin.published? }
  end

  test '#publish failed' do
    bulletin = bulletins(:under_moderation)
    user = users(:jane)
    sign_in user

    patch publish_bulletin_path(bulletin)

    assert_response :redirect

    bulletin.reload

    assert { !bulletin.published? }
  end

  test '#archive successful' do
    bulletin = bulletins(:two)
    user = users(:admin)
    sign_in user

    patch archive_bulletin_path(bulletin)

    assert_response :redirect

    bulletin.reload

    assert { bulletin.archived? }
  end

  test '#reject successful' do
    bulletin = bulletins(:under_moderation)
    user = users(:admin)
    sign_in user

    patch reject_bulletin_path(bulletin)

    assert_response :redirect

    bulletin.reload

    assert { bulletin.rejected? }
  end

  test '#to_moderate successful' do
    bulletin = bulletins(:draft)
    user = users(:admin)
    sign_in user

    patch to_moderate_bulletin_path(bulletin)

    assert_response :redirect

    bulletin.reload

    assert { bulletin.under_moderation? }
  end
end
