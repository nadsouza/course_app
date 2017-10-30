require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @course = courses(:web)
    @second_course = courses(:test)
    @category = Category.new(name: 'Test Category')
  end

  test 'should be valid' do
    assert @category.valid?
  end

  test 'category is capitalized' do
    @category.name = 'test category'
    @category.save
    assert_equal 'Test Category', @category.name
  end

  test 'has many courses' do
    @category.courses << @course
    @category.courses << @second_course
    assert_equal 2, @category.courses.length
  end

  test 'name already exists' do
    @category.save
    new_category = Category.new(name: 'Test Category')
    assert_not new_category.valid?
  end

  test 'name is blank' do
    @category.name = ''
    assert_not @category.valid?
  end

  test 'name is less than 2 characters long' do
    @category.name = '1'
    assert_not @category.valid?
  end

  test 'name is greater than 32 characters long' do
    @category.name = '1' * 33
    assert_not @category.valid?
  end

  test 'name is invalid' do
    # Containing special characters
    @category.name = 'abc@3323$$'
    assert_not @category.valid?
  end
end
