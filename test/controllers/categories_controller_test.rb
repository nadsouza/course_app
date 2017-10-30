require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    # Create an existing user
    @user = User.create(
      firstname: 'Example',
      lastname: 'User',
      email: 'example.user@rmit.edu.au',
      password: 'Password123',
      password_confirmation: 'Password123'
    )

    # Fixtures
    @category = categories(:web)
    @course = courses(:web)

    @course.categories << @category
  end

  test "guest should not create categories" do
    # Visit new category path
    get new_category_path

    # Follow redirect
    follow_redirect!

    # Should redirect login
    assert_equal request.path_info, login_path

    # Attempt to create a category through POST
    post categories_path

    # Follow redirect
    follow_redirect!

    # Should redirect login
    assert_equal request.path_info, login_path
  end

  test 'guest and logged in user can visit individual category page' do
    # Visit all categories path
    get categories_path(@category)

    # Should have no redirection
    assert_response :success

    # Login as category
    login_as @user

    # Visit all categories path
    get categories_path(@category)

    # Should have no redirection
    assert_response :success
  end

  test 'delete category successful' do
    # Login as admin
    login_as_admin

    # Delete category
    delete category_path(@category.id)

    # Category should not exist
    assert_not Category.exists?(id: @category.id)

    # The first assigned category should not exist
    assert @course.categories.first.blank?
  end

  test 'update category successful' do
    # Login as user
    login_as @user

    # Build params
    category_params = {}
    category_params[:id] = @category.id
    category_params[:name] = 'test'

    # Post params
    put category_path(@category.id), params: { category: category_params }

    # Follow redirect
    follow_redirect!

    # Show success message
    assert flash[:success].present?

    # Should redirect login
    assert_equal request.path_info, categories_path
  end
end
