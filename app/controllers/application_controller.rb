class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user,
                :current_merchant?,
                :registered_user?,
                :current_admin?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def registered_user?
    current_user && registered_user?
  end

  def current_merchant?
    current_user && merchant?
  end

  def current_admin?
    current_user && admin?
  end
end
