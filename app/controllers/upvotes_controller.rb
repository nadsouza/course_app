class UpvotesController < ApplicationController
  # Middleware
  before_action :logged_users_only

  def new
    course = Course.find_by_id(params[:id])
    condition = { user_id: current_user.id, course_id: params[:id] }

    # If upvote exists
    if Upvote.exists?(condition)
      flash_danger("You have already voted for #{course.name} course.", :back)
    elsif Downvote.exists?(condition)
      # Cannot allow course to be both upvote and downvote
      flash_danger("You have already downvoted #{course.name} course.", :back)
    else
      # Add upvote to DB
      course.upvotes << Upvote.create(user_id: current_user.id, course_id: course.id)
      flash_success("Successfully upvoted #{course.name} course.", :back)
    end
  end
end