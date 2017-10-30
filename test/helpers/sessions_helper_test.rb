require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  def setup
    @user = users(:john)
    remember @user
  end

  test 'current_user returns right user when session is nil' do
    assert_equal @user, current_user
    assert logged_in?
  end

  test 'current_user returns nil when forgotten' do
    # Clean remember digest
    @user.forget

    # Current user should not exist
    assert_nil current_user
  end

  test 'current_user returns nil when different digest' do
    # Change remember token in DB
    @user.update_attribute(:remember_digest, User.digest(User.new_token))

    # Current user should not exist
    assert_nil current_user
  end
end