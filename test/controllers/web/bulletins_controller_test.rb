# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:one)
  end

  test '#index' do
    get root_path
    assert_response :success
  end

  test '#new' do
    get new_bulletin_path
    assert_response :success
  end

  # test '#create' do
  #   assert_difference('Bulletin.count') do
  #     post root_path, params: { bulletin: {} }
  #   end

  #   assert_redirected_to bulletin_path(Bulletin.last)
  # end

  test '#show' do
    get bulletin_path(@bulletin)
    assert_response :success
  end

  test '#edit' do
    get edit_bulletin_path(@bulletin)
    assert_response :success
  end

  # test '#update' do
  #   patch bulletin_path(@bulletin), params: { bulletin: {} }
  #   assert_redirected_to bulletin_path(@bulletin)
  # end

  # test '#destroy' do
  #   assert_difference('Bulletin.count', -1) do
  #     delete bulletin_path(@bulletin)
  #   end

  #   assert_redirected_to root_path
  # end

  test '#change_state' do

  end
end
