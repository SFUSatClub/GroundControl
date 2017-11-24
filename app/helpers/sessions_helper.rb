module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
    flash[:success] = "Welcome back " + user.name
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user


  def log_out
    session.delete(:user_id)
    @current_user = nil
    flash[:success] = "You have been signed out."
  end

end
