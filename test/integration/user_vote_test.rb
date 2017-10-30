require 'test_helper'

class UserVoteTest < ActionDispatch::IntegrationTest
  def setup
    # Create an existing user
    @user = User.create(
      firstname: 'Example',
      lastname: 'User',
      email: 'example.user@rmit.edu.au',
      password: 'Password123',
      password_confirmation: 'Password123'
    )
    @second_user = users(:john)
    @course = courses(:web)
  end

  test 'logged in should be able to upvote' do
    # Login
    login_as @user

    # Send POST to vote
    post upvote_path(@course)

    follow_redirect!

    # Success message
    assert flash[:success].present?

    assert Upvote.exists?(course_id: @course.id)
  end

  test 'guests should not upvote' do
    # Send POST to vote
    post upvote_path(@course)

    # Error message
    assert flash[:danger].present?

    assert_not Upvote.exists?(course_id: @course.id)
  end

  test 'user can only upvote once' do
    # Login
    login_as @user

    # Send POST to vote
    post upvote_path(@course)

    follow_redirect!

    # Send POST to vote
    post upvote_path(@course)

    follow_redirect!

    # Error message
    assert flash[:danger].present?
  end

  test 'user cannot downvote after upvote and vice versa' do
    # Login
    login_as @user

    # Send POST to vote
    post upvote_path(@course)

    follow_redirect!

    # Send POST to vote
    post downvote_path(@course)

    follow_redirect!

    # Error message
    assert flash[:danger].present?

    # Send POST to vote
    post downvote_path(@course)

    follow_redirect!

    # Send POST to vote
    post upvote_path(@course)

    follow_redirect!

    # Error message
    assert flash[:danger].present?
  end

  test 'reset votes' do
    # Login
    login_as_admin

    # Create votes
    Upvote.create(course_id: @course.id, user_id: @user.id)
    Downvote.create(course_id: @course.id, user_id: @second_user.id)

    # Send DELETE request to reset votes
    delete reset_votes_path(@course)

    follow_redirect!

    # Success message
    assert flash[:success].present?

    # Votes should not exist
    assert_not Upvote.exists?(course_id: @course.id)
    assert_not Downvote.exists?(course_id: @course.id)
  end
end