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
        redirect_to profile_path
      end
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password]) && user.role != "merchant" || active_merchant?(user)
      session[:user_id] = user.id
      flash[:notice] = "Login successful!"

      if user.registered_user?
        redirect_to profile_path
      elsif user.merchant?
        redirect_to dashboard_path
      elsif user.admin?
        redirect_to root_path
      end

    else
      flash[:notice] = 'Invalid Credentials'
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    flash[:notice] = "Successfully logged out"
    redirect_to root_path
  end

  private

  def active_merchant?(user)
    (user && user.role == 'merchant' && user.enabled == true && user.authenticate(params[:password]))
  end 
end
