# frozen_string_literal: true

require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:one)
    @user = users(:admin)
  end

  test '#index' do
    sign_in @user

    get admin_categories_path
    assert_response :success
  end

  test '#index unauthorized' do
    get admin_categories_path
    assert_response :redirect
  end

  test '#new' do
    sign_in @user

    get new_admin_category_path
    assert_response :success
  end

  test '#edit' do
    sign_in @user

    get edit_admin_category_path(@category)
    assert_response :success
  end

  test '#create' do
    sign_in @user

    attrs = {
      name: Faker::Mountain.name,
      slug: Faker::Lorem.word
    }

    post admin_categories_path, params: { category_form: attrs }

    assert_response :redirect

    category = Category.find_by(attrs)

    assert { category.present? }
  end

  test '#update' do
    sign_in @user

    new_attrs = {
      name: Faker::Mountain.name,
      slug: Faker::Lorem.word
    }

    patch admin_category_path(@category), params: { category_form: new_attrs }

    assert_response :redirect

    @category.reload

    assert { @category.name == new_attrs[:name] }
  end

  test '#destroy' do
    sign_in @user

    category_without_bulletins = categories(:without_bulletins)

    delete admin_category_path(category_without_bulletins)

    assert_response :redirect
    category = Category.find_by id: category_without_bulletins.id

    assert { category.blank? }
  end
end
