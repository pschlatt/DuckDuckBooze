class UsersController < ApplicationController
  before_action :check_user_status, except: [:new, :create]

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
      flash[:notice] = 'Missing required field(s). Please try again.'
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

  def check_user_status
    render file: "/public/404", status: 404 unless registered_user?
  end
end
