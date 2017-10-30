class ApplicationController < ActionController::Base
  include ApplicationHelper
  include SessionsHelper

  protect_from_forgery with: :exception

  before_action :populate

  def populate
    # Location
    @locations = Location.all.order(:name)
    @location = Location.new

    # Cateogry
    @categories = Category.all.order(:name)
    @category = Category.new

    # Course
    @courses = Course.all.order(:name)
    @course = Course.new

    # Prereq
    @prerequisites = Prerequisite.all.order(:name)
  end
end
