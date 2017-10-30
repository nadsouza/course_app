require 'test_helper'

class AdminSessionTest < ActionDispatch::IntegrationTest
  def setup
    # User parameters
    @user_params = {
      email: 'admin',
      password: 'password',
    }
  end

  test 'admin login' do
    post login_url,
      params: { session: @user_params }

    # Show success message
    assert flash[:success].present?

    # User should be logged in
    assert logged_in_admin?
  end

  test 'admin logout' do
    # Login as admin
    login_as_admin

    # Send delete request type to logout
    delete logout_path

    # Show success message
    assert flash[:success].present?
  end
end