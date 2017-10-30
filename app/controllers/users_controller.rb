class UsersController < ApplicationController
  include SessionsHelper

  # Middleware
  before_action :guests_only, only: [:new, :create]
  before_action :admin_only, only: [:destroy]

  def destroy
    user = User.find(params[:id]).destroy
    flash_success("Successfully deleted #{user.full_name} user!", :back)
  end

  def edit
    @user = User.find(params[:id])

    # Make sure standard users cannot edit other users
    return admin_only if (@user.id != current_user.id)
  end

  def index
    @users = User.where.not(email: 'admin')
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @courses = Course.where(user_id: params[:id])
    @votes = @user.upvotes + @user.downvotes
    @votes.sort_by! { |h| h[:updated_at] }.reverse!
  end

  def create
    # Start a new User
    @user = User.new(user_params)

    # Save user to DB
    if @user.save
      # Handle a successful save.
      flash_success('Successfully registered a coordinator, please login.', login_path)
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])

    # Make sure standard users cannot edit other users
    return admin_only if (@user.id != current_user.id)

    # Get user params
    user_params = params.require(:user).permit([:firstname, :lastname, :email, :password, :password_confirmation])

    @user.assign_attributes(user_params)

    if @user.save
      flash_success("Successfully updated #{@user.full_name} profile!", user_path(@user))
    else
      render 'edit'
    end
  end

  private
    def user_params
      if params[:user].nil? or params[:user].empty?
        return false
      else
        return params.require(:user).permit(
          :firstname,
          :lastname,
          :email,
          :password,
          :password_confirmation
        )
      end
    end
end
