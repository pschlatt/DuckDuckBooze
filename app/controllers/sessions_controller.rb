class SessionsController < ApplicationController

  def new
    if session[:user_id]
      if current_admin?
        flash[:notice] = "You are already logged in."
        redirect_to root_path
      elsif current_merchant?
        flash[:notice] = "You are already logged in."
        redirect_to dashboard_path
      elsif registered_user?
        flash[:notice] = "You are already logged in."
        redirect_to profile_path(session[:user_id])
      end
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to profile_path
    else
      render :new
    end
  end
end