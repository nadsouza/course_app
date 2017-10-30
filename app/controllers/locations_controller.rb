class LocationsController < ApplicationController
  # Middleware
  before_action :logged_users_only, only: [:create, :new]
  before_action :admin_only, only: [:destroy]

  def create
    new_location = params.require(:location).permit(:name)
    @location = Location.new(new_location)

    if @location.save
      flash_success("Successfully created #{@location.name} location!", locations_path)
    else
      render 'new'
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def destroy
    # Delete course
    location = Location.find(params[:id]).destroy
    flash_success("Successfully deleted #{location.name} location!", :back)
  end

  def index
  end

  def new
    @location = Location.new()
  end

  def show
    @location = Location.find(params[:id])
    @courses = @location.courses
  end

  def update
    @location = Location.find(params[:id])

    # Get user params
    location_params = params.require(:location).permit([:name])

    @location.assign_attributes(location_params)

    if @location.save
      flash_success("Successfully updated #{@location.name} location!", locations_path)
    else
      render 'edit'
    end
  end
end