class CoursesController < ApplicationController
  include CoursesHelper

  # Middleware
  before_action :logged_users_only, except: [:index, :show]
  before_action :admin_only, only: [:destroy, :reset_votes]

  def create
    @course_params = params.require(:course).permit([:name, :description, :image, :prerequisites => [], :locations => [], :categories => []])

    # Clean empty strings in params array
    clean_params

    # Replace id strings to collection
    replace_id_collection

    # Assign user to params
    assign_to_course_params(user_id: current_user.id)

    # New course
    @course = Course.new(@course_params)

    if !@course.errors.any? && @course.valid?
      @course.save
      flash_success("Successfully created #{@course.name} course!", courses_path)
    else
      render 'new'
    end
  end

  def destroy
    # Delete course
    course = Course.find(params[:id])
    course.destroy

    # Delete all prereq
    Prerequisite.where(id: params[:id]).destroy_all

    flash_success("Successfully deleted #{course.name} course!", :back)
  end

  def edit
    @course = Course.find(params[:id])
    @courses = Course.where.not(id: params[:id]).order(:name)
  end

  def index
  end

  def new
  end

  def show
    @course = Course.find(params[:id])
  end

  def update
    # Get course params
    @course_params = params.require(:course).permit([:name, :description, :image, :prerequisites => [], :locations => [], :categories => []])

    # New course
    @course = Course.where(id: params[:id]).first

    # Clean empty strings in params array
    clean_params

    # Replace id strings to collection
    replace_id_collection

    @course.assign_attributes(@course_params)

    # Save course
    if !@course.errors.any? && @course.valid?
      @course.save
      flash_success("Successfully updated #{@course.name} course!", courses_path)
    else
      render 'edit'
    end
  end

  def reset_votes
    course = Course.find(params[:id])

    if (course.upvotes.present? || course.downvotes.present?)
      # Delete associated upvotes
      course.upvotes.each do |u|
        u.destroy
      end

      # Delete associated downvotes
      course.downvotes.each do |d|
        d.destroy
      end

      flash_success("Successfully reset all votes on #{course.name} course!", courses_path)
    else
      flash_danger("There are no votes to reset #{course.name} course.", courses_path)
    end
  end
end
