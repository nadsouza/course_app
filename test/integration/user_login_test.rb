require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  def setup
    # User parameters
    @user_params = {
      email: 'example.user@rmit.edu.au',
      password: 'Password123',
    }

    # Create an existing user
    @user = User.create(
      firstname: 'Example',
      lastname: 'User',
      email: @user_params[:email],
      password: @user_params[:password],
      password_confirmation: @user_params[:password]
    )
  end

  test 'should get new' do
    get login_url
    assert_response :success
  end

  test 'login successful' do
    get login_url
    post login_url,
      params: { session: @user_params }

    # Show success message
    assert flash[:success].present?

    # Follow
    follow_redirect!

    # Redirect page should by home page
    assert_equal request.path_info, root_path

    # User should be logged in
    assert logged_in_session?

    # Cookies should not exist
    assert cookies[:user_id].nil?
  end

  test 'login with remembering' do
    login_as @user, remember_me: '1'

    # Success message should exist
    assert flash[:success].present?

    # Redirect page should by home page
    assert_equal request.path_info, root_path

    # User should be logged in
    assert logged_in_session?

    # Simulate session expire
    session[:user_id] = nil

    # Remember token should exist in cookie
    assert_not_empty cookies['remember_token']
  end

  test 'no remember token' do
    assert_not @user.authenticated?('')
  end

  test 'invalid login details' do
    get login_url

    # Set email and password as empty
    @user_params[:email] = ''
    @user_params[:password] = ''

    # Send post request to login
    post login_url,
      params: { session: @user_params }
    assert flash[:danger].present?
  end
end
