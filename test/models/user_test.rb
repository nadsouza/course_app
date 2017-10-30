require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    # Ideal user
    # User is not saved to DB
    @user = User.new(
      firstname: 'Example',
      lastname: 'User',
      email: 'example.user@rmit.edu.au',
      password: 'Password123',
      password_confirmation: 'Password123'
    )
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'first name should be present' do
    @user.firstname = ' '
    assert_not @user.valid?
    assert @user.errors.messages[:firstname].include? 'can\'t be blank'
  end

  test 'first name should not be too long' do
    @user.firstname = 'a' * 64
    assert_not @user.valid?
    assert @user.errors.messages[:firstname].include? 'is too long (maximum is 24 characters)'
  end

  test 'first name should not be too short' do
    @user.firstname = 'a'
    assert_not @user.valid?
    assert @user.errors.messages[:firstname].include? 'is too short (minimum is 3 characters)'
  end

  test 'first name is invalid' do
    # Contains a special character
    @user.firstname = 'j@hn'
    assert_not @user.valid?

    # Contains a space
    @user.firstname = 'john doe'
    assert_not @user.valid?

    # Contains numbers
    @user.firstname = 'john123'
    assert_not @user.valid?
  end

  test 'last name should be present' do
    @user.lastname = ' '
    assert_not @user.valid?
    assert @user.errors.messages[:lastname].include? 'can\'t be blank'
  end

  test 'last name should not be too long' do
    @user.lastname = 'a' * 64
    assert_not @user.valid?
    assert @user.errors.messages[:lastname].include? 'is too long (maximum is 24 characters)'
  end

  test 'last name should not be too short' do
    @user.lastname = 'a'
    assert_not @user.valid?
    assert @user.errors.messages[:lastname].include? 'is too short (minimum is 3 characters)'
  end

  test 'last name is invalid' do
    # Contains a special character
    @user.lastname = 'd@e'
    assert_not @user.valid?

    # Contains a space
    @user.lastname = 'john doe'
    assert_not @user.valid?

    # Contains numbers
    @user.lastname = 'doe123'
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = ' '
    assert_not @user.valid?
    assert @user.errors.messages[:email].include? 'can\'t be blank'
  end

  test 'email should not be too long' do
    @user.email = 'a' * 255 + '@email.com'
    assert_not @user.valid?
    assert @user.errors.messages[:email].include? 'is too long (maximum is 255 characters)'
  end

  test 'email should not be too short' do
    @user.email = 'a'
    assert_not @user.valid?
    assert @user.errors.messages[:email].include? 'is too short (minimum is 2 characters)'
  end

  test 'email is invalid' do
    @user.email = 'aaa@aa.C@m'
    assert_not @user.valid?

    # Email is not in the correct format
    # <firstname>.<lastname>@rmit.edu.au
    @user.email = 'example@email.com'
    assert_not @user.valid?

    # No period in the email name
    @user.email = 'johndoe@rmit.edu.au'
    assert_not @user.valid?

    # Domain is incorrect
    @user.email = 'jen.doe@email.com'
    assert_not @user.valid?

    # Domain is correct but email name is invalid
    @user.email = 'example@rmit.edu.au'
    assert_not @user.valid?
  end

  test 'email addresses should be unique' do
    duplicate_user = User.new(email: @user.email)
    @user.save
    assert_not duplicate_user.valid?
    assert duplicate_user.errors.messages[:email].include? 'has already been taken'
  end

  test 'email is lowercase' do
    @user.email = 'EXAMPLE.USER@RMIT.EDU.AU'
    @user.save
    assert @user.email == 'example.user@rmit.edu.au'
  end

  test 'password should be present' do
    @user.password = ''
    @user.password_confirmation = ''
    assert_not @user.valid?
    assert @user.errors.messages[:password_confirmation].include? 'can\'t be blank'
  end

  test 'password should be at least 8 characters' do
    @user.password = 'a' * 5
    assert_not @user.valid?
    assert @user.errors.messages[:password].include? 'is too short (minimum is 8 characters)'
  end

  test 'password should be less than 32 characters' do
    @user.password = 'a' * 64
    assert_not @user.valid?
    assert @user.errors.messages[:password].include? 'is too long (maximum is 32 characters)'
  end

  test 'password must contain at least one uppercase letter' do
    @user.password = 'password123'
    assert_not @user.valid?
    assert @user.errors.messages[:password].include? 'is invalid (must contain an uppercase letter and a number)'

    @user.password = 'p223ssword223'
    assert_not @user.valid?
    assert @user.errors.messages[:password].include? 'is invalid (must contain an uppercase letter and a number)'

    @user.password = 'passwoRd123'
    @user.password_confirmation = @user.password
    assert @user.valid?

    @user.password = '123passwoRD'
    @user.password_confirmation = @user.password
    assert @user.valid?

    @user.password = 'pa@@###wordD123'
    @user.password_confirmation = @user.password
    assert @user.valid?

    @user.password = 'PASSWORD3322s11!@#$%^&*'
    @user.password_confirmation = @user.password
    assert @user.valid?
  end

  test 'password must contain at least one number' do
    @user.password = 'Password'
    assert_not @user.valid?

    @user.password = 'P@@@@ssword'
    assert_not @user.valid?
    assert @user.errors.messages[:password].include? 'is invalid (must contain an uppercase letter and a number)'
  end

  test 'password confirmation should be present' do
    @user.password_confirmation = ''
    assert_not @user.valid?
    assert @user.errors.messages[:password_confirmation].include? 'doesn\'t match Password'
  end

  test 'get user full name' do
    assert_equal @user.full_name, "#{@user.firstname} #{@user.lastname}"
  end
end