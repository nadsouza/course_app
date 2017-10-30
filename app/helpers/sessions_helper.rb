module SessionsHelper
  # Logs in the given user.
  def login(user)
    # Set the session user ID from the selected user
    session[:user_id] = user.id
  end

  # Set session admin
  def login_admin(email, password)
    if email == 'admin' && password == 'password'
      session[:admin] = true
      return true
    else
      return false
    end
  end

  def remember(user)
    # Remember selected user
    user.remember

    # Set permanent signed (encrypted) user ID
    cookies.permanent.signed[:user_id] = user.id

    # Set premanent remember token
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Logout by deleting session
  def logout
    forget current_user
    session.delete(:user_id)
    session.delete(:admin) if is_admin?
    @current_user = nil
  end

  # Returns the current logged-in user (if any).
  def current_user
    return @current_user = get_admin if is_admin?

    if user_id = session[:user_id]
      # Find by session user ID
      @current_user ||= User.find_by(id: user_id)
    elsif user_id = cookies.signed[:user_id]
      # Find by cookies user ID
      user = User.find_by(id: user_id)
      if user and user.authenticated?(cookies[:remember_token])
        # Login user
        login user

        # Make current logged in user as found user
        @current_user = user
      end
    end
  end

  # Check if an admin exists
  def get_admin
    admin = User.find_by(email: 'admin')

    if !admin
      # Create dummay data for admin
      new_admin = User.new(firstname: 'Administrator', lastname: 'RMIT', password: nil, email: 'admin')
      new_admin.save(validate: false)
    end

    return admin
  end

  def is_admin?
    !session[:admin].nil?
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Redirect to login if not logged in
  def logged_users_only
    message = 'Logged in users are only allowed to do that action. Redirecting to login page, sorry for the inconvenience.'
    flash_danger(message, login_path) if !logged_in?
  end

  # Redirect to root if logged in
  def guests_only
    message = 'Guests are only allowed to do that action. Redirecting to hompage, sorry for the inconvenience.'
    flash_danger(message, root_path) if logged_in?
  end

  # Redirect if not admin
  def admin_only
    message = 'Admins are only allowed to do that action. Redirecting to hompage, sorry for the inconvenience.'
    flash_danger(message, root_path) if !is_admin?
  end

  # Redirect if not admin
  def not_admin
    message = 'Normal users are only allowed to do that action. Redirecting to hompage, sorry for the inconvenience.'
    flash_danger(message, root_path) if is_admin?
  end
end
