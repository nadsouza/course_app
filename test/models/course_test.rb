require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  def setup
    @location = Location.create(
      name: '000.00.000'
    )

    @category = Category.create(
      name: 'Test Category'
    )

    @course = Course.new(
      name: 'Example Course',
      description: 'Example description' * 30,
      locations: [@location],
      categories: [@category]
    )
  end

  test 'should be valid' do
    assert @course.valid?
  end

  test 'name should be present' do
    @course.name = ' '
    assert_not @course.valid?
    assert @course.errors.messages[:name].include? 'can\'t be blank'
  end

  test 'name should not be too long' do
    @course.name = 'a' * 64
    assert_not @course.valid?
    assert @course.errors.messages[:name].include? 'is too long (maximum is 32 characters)'
  end

  test 'name should not be too short' do
    @course.name = 'a'
    assert_not @course.valid?
    assert @course.errors.messages[:name].include? 'is too short (minimum is 2 characters)'
  end

  test 'name is invalid' do
    # Contains a special character
    @course.name = 'w@b'
    assert_not @course.valid?
  end

  test 'description should be present' do
    @course.description = ' '
    assert_not @course.valid?
    assert @course.errors.messages[:description].include? 'can\'t be blank'
  end

  test 'description should not be too long' do
    @course.description = 'a' * 2000
    assert_not @course.valid?
    assert @course.errors.messages[:description].include? 'is too long (maximum is 1024 characters)'
  end

  test 'description should not be too short' do
    @course.description = 'a'
    assert_not @course.valid?
    assert @course.errors.messages[:description].include? 'is too short (minimum is 30 characters)'
  end
end
