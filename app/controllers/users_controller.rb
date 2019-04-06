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
      flash[:notice] = @user.errors.full_messages.join
      render :new
    end
  end

  def show
    @user = User.find(current_user[:id])
  end

  def edit

  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :street, :city, :state, :zip, :email)
  end
end
