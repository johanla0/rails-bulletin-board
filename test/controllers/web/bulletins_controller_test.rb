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

  test '#show authorized unpublished successful' do
    sign_in @user

    get bulletin_path(@bulletin)
    assert_response :success
  end

  test '#show unauthorized unpublished failed' do
    get bulletin_path(@bulletin)
    assert_response :redirect
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

  test '#archive as user successful' do
    user = users(:jane)
    sign_in user

    bulletin = bulletins(:two)

    patch archive_bulletin_path(bulletin)

    assert_response :redirect

    bulletin.reload

    assert { bulletin.archived? }
  end

  test '#to_moderate as user successful' do
    user = users(:jane)
    sign_in user

    bulletin = bulletins(:draft)

    patch to_moderate_bulletin_path(bulletin)

    assert_response :redirect

    bulletin.reload

    assert { bulletin.under_moderation? }
  end
end
