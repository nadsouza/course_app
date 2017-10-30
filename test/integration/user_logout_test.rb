require 'test_helper'

class UserLogoutTest < ActionDispatch::IntegrationTest
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

  test 'logout successful' do
    # Login
    login_as @user

    # User should be logged in first
    assert logged_in_session?

    # Send destory request type to logout
    delete logout_path

    # Check if success message exists
    assert_not flash[:success].nil?

    # Check if user is not logged in
    assert_not logged_in_session?

    # Follow
    follow_redirect!

    # Check if page redirects to home page
    assert_equal request.path_info, root_path
  end


  test 'guest cannot logout' do
    # Visit logout path
    delete logout_path

    # Follow redirect
    follow_redirect!

    # Should redirect login
    assert_equal request.path_info, login_path
  end
end
