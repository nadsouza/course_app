require 'test_helper'

class LocationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    # Create an existing user
    @user = User.create(
      firstname: 'Example',
      lastname: 'User',
      email: 'example.user@rmit.edu.au',
      password: 'Password123',
      password_confirmation: 'Password123'
    )

    # Use a fixture for location
    @location = locations(:locationOne)
    @course = courses(:web)

    # Add location to course categories
    @course.locations << @location
  end

  test "guest should not create locations" do
    # Visit new location path
    get new_location_path

    # Follow redirect
    follow_redirect!

    # Should redirect login
    assert_equal request.path_info, login_path

    # Attempt to create a location through POST
    post locations_path

    # Follow redirect
    follow_redirect!

    # Should redirect login
    assert_equal request.path_info, login_path
  end

  test 'guest and logged in user can visit individual location page' do
    # Visit all locations path
    get locations_path(@location)

    # Should have no redirection
    assert_response :success

    # Login as location
    login_as @user

    # Visit all locations path
    get locations_path(@location)

    # Should have no redirection
    assert_response :success
  end

  test 'delete location successful' do
    # Login as admin
    login_as_admin

    # Delete location
    delete location_path(@location.id)

    # location should not exist
    assert_not Location.exists?(id: @location.id)

    # The first assigned location should not exist
    assert @course.locations.first.blank?
  end

  test 'update location successful' do
    # Login as user
    login_as @user

    # Build params
    location_params = {}
    location_params[:id] = @location.id
    location_params[:name] = '002.02.002'

    # Post params
    put location_path(@location.id), params: { location: location_params }

    # Follow redirect
    follow_redirect!

    # Show success message
    assert flash[:success].present?

    # Should redirect login
    assert_equal request.path_info, locations_path
  end
end
