class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    if session[:user_id]
      return User.find(session[:user_id])
    else
      return nil
    end
  end

  def logged_in?
    if session[:user_id]
      return true
    else
      return false
    end
  end


  # could not write a test for this - need to find a way to do it
  def users_only
    unless logged_in?
      redirect_to(:sign_in)
      return false
    end

    return true
  end

end
