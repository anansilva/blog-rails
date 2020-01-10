class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    end
  end

  def authenticate_user!
    redirect_to login_path unless current_user
  end
end
