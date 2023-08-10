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

  test '#change_state successful' do
    bulletin = bulletins(:two)
    user = users(:admin)
    sign_in user

    patch change_state_bulletin_path(bulletin), params: { state_event: :publish }

    assert_response :success

    bulletin.reload

    assert { bulletin.published? }
  end

  test '#change_state failed' do
    bulletin = bulletins(:two)
    user = users(:jane)
    sign_in user

    patch change_state_bulletin_path(bulletin), params: { state_event: :publish }

    assert_response :redirect

    bulletin.reload

    assert { !bulletin.published? }
  end
end
