class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save 
      session[:user_id] = @user.id
      flash[:success] = 'You are now registered and logged in.'
      redirect_to profile_path
    else
      render :new
    end 
  end

  def show
    @user = User.find(current_user[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :street, :city, :state, :zip, :email)
  end 
end
