class SessionsController < ApplicationController

  def new
    if session[:user_id]
      # binding.pry
      flash[:notice] = "You are already logged in."
      redirect_to profile_path(session[:user_id])
    end
  end

  def create
    user = User.find_by(email: params[:email])
    # binding.pry
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      # binding.pry
      redirect_to profile_path(user)
    else
      render :new
    end
  end

end
