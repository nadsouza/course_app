class SessionsController < ApplicationController
  # Middleware
  before_action :logged_users_only, only: :destroy
  before_action :guests_only, only: [:new, :create]

  def new
  end

  def create
    email = params[:session][:email]
    password = params[:session][:password]
    remember_me ||= params[:session][:remember_me]

    # Find user by email
    user = User.find_by(email: email.downcase)

    # If user wants to login as admin
    if email == 'admin'
      if login_admin(email, password)
        # Return to skip the process below
        return flash_success('Successfully logged in as an administrator.', root_path)
      else
        # Mimic the same error as a normal login attempt
        flash_danger('Invalid password/email, please try again.')

        # Return to skip the process below
        return render 'new'
      end
    end

    if user and user.authenticate(password)
      # Check if remember me param is true
      remember_me == '1' ? remember(user) : forget(user)

      # Set a session through login function
      login user

      # Redirect to home page
      flash_success('Successfully logged in.', root_path)
    else
      # Show error
      flash_danger('Invalid password/email, please try again.')

      # Render login form again
      render 'new'
    end
  end

  def destroy
    if logged_in?
      logout
      flash_success('Successfully logged out.', root_path)
    end
  end
end
