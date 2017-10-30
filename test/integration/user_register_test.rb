require 'test_helper'

class UserRegisterTest < ActionDispatch::IntegrationTest
  def setup
    # User parameters
    # An ideal valid user
    @user_params = {
      firstname: 'example',
      lastname: 'user',
      email: 'example.user@rmit.edu.au',
      password: 'Password123',
      password_confirmation: 'Password123',
    }

    @user = User.new(@user_params)
  end

  test "invalid signup information" do
    get register_path

    # Check if total user count changes
    assert_no_difference 'User.count' do
      # Make a mistake in the param
      # In this case it's the empty email
      @user_params[:email] = ''

      # Post request data
      post users_path, params: { user: @user_params }
    end

    assert_template 'users/new'
  end

  test 'register successful' do
    get register_path
    post users_path, params: { user: @user_params }

    # Follow
    follow_redirect!

    # Show success message
    assert flash[:success].present?

    # Check if page redirects to login page
    assert_equal request.path_info, login_path
  end

  test 'logged in user should not register' do
    # Create user in DB
    user = User.create(@user_params)

    # Login as user
    login_as user

    # Visit registration page
    post users_path

    # Follow redirect
    follow_redirect!

    # Check if page redirects to root
    assert_equal request.path_info, root_path
  end
end