ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Check if user is logged in
  # Use this method instead of SessionHelper
  def logged_in_session?
    !session[:user_id].nil?
  end

  # Check if admin is logged in via session
  def logged_in_admin?
    !session[:admin].nil?
  end

  # Login as a user
  def login_as(user)
    session[:user_id] = user.id
  end

  # Login as a admin
  def login_as_admin
    session[:admin] = true
  end

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  # Login
  def login_as(user, password: 'Password123', remember_me: '1')
    post login_path, params: {
      session: {
        email: user.email,
        password: user.password,
        remember_me: remember_me
      }
    }

    # Follow redirect
    follow_redirect!
  end

  # Login as a admin
  def login_as_admin
    post login_path, params: {
      session: {
        email: 'admin',
        password: 'password',
      }
    }

    # Follow redirect
    follow_redirect!
  end
end