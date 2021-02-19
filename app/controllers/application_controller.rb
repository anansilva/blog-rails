class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :switch_locale

  def switch_locale
    locale = params[:locale] || I18n.default_locale
    I18n.locale = locale
  end

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    redirect_to admin_login_path unless current_user
  end

  def default_url_options
    {
      host: ENV["DOMAIN"] || "localhost:3000",
      locale: I18n.locale
    }
  end
end
