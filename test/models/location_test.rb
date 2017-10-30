require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  def setup
    @course = courses(:web)
    @second_course = courses(:test)
    @location = Location.new(name: '000.00.000')
  end

  test 'should be valid' do
    assert @location.valid?
  end

  test 'has many courses' do
    @location.courses << @course
    @location.courses << @second_course
    assert_equal 2, @location.courses.length
  end

  test 'name already exists' do
    @location.save
    new_location = Location.new(name: '000.00.000')
    assert_not new_location.valid?
  end

  test 'name is blank' do
    @location.name = ''
    assert_not @location.valid?
  end

  test 'name is not 10 characters long' do
    @location.name = '1'
    assert_not @location.valid?

    @location.name = '1' * 11
    assert_not @location.valid?
  end

  test 'name is invalid' do
    # Containing letters
    @location.name = 'abc'
    assert_not @location.valid?

    # Containing numbers but incorrect format
    @location.name = '110020030'
    assert_not @location.valid?
  end
end
