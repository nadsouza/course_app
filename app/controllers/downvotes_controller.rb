class DownvotesController < ApplicationController
  # Middleware
  before_action :logged_users_only

  def new
    course = Course.find_by_id(params[:id])
    condition = { user_id: current_user.id, course_id: params[:id] }

    # If vote exists
    if Downvote.exists?(condition)
      flash_danger("You have already voted for #{course.name} course.", :back)
    elsif Upvote.exists?(condition)
      # Cannot allow course to be both upvote and downvote
      flash_danger("You have already upvoted #{course.name} course.", :back)
    else
      # Add vote to DB
      course.downvotes << Downvote.create(user_id: current_user.id, course_id: course.id)
      flash_success("Successfully downvoted #{course.name} course.", :back)
    end
  end
end