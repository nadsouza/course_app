require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    # Create an existing user
    @user = User.create(
      firstname: 'Example',
      lastname: 'User',
      email: 'example.user@rmit.edu.au',
      password: 'Password123',
      password_confirmation: 'Password123'
    )
  end

  test 'delete user successful' do
    login_as_admin

    # Delete course
    delete user_path(@user.id)

    # User should not exist
    assert_not User.exists?(id: @user.id)
  end

  test 'should get register page' do
    get register_url
    assert_response :success
    assert_select 'title', "Registration - RMIT Course App"
  end

  test 'should get login page' do
    get login_url
    assert_response :success
    assert_select 'title', 'Login - RMIT Course App'
  end

  test 'guest can visit register page' do
    # Visit registration page
    post users_path

    # Should not redirect
    assert_response :success
  end

  test 'guest and logged in user can visit individual user page' do
    # Visit all users path
    get users_path(@user)

    # Should have no redirection
    assert_response :success

    # Login as user
    login_as @user

    # Visit all users path
    get users_path(@user)

    # Should have no redirection
    assert_response :success
  end

  # test 'register page stay on the same page after error' do
  #   get register_url
  #   post users_url,
  #     params: { user: @user_params }

  #   # Follow the redirect from controller
  #   follow_redirect!

  #   assert_equal request.path_info, register_path
  # end

  # test 'register page flash errors should exist' do
  #   get register_url
  #   post users_url,
  #     params: { user: @user_params }
  #   follow_redirect!
  #   assert flash[:errors].present?
  # end
end
