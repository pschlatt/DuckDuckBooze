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
      flash[:notice] = @user.errors.full_messages.join(", ")
      render :new
    end
  end

  def show
    @user = User.find(current_user[:id])
  end

  def edit
    @user = current_user
  end

  def update
    if current_user.update(update_params)
      redirect_to profile_path
      flash[:success] = 'You have updated your profile'
    else
      @errors = current_user.errors.full_messages
      @user = current_user
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :street, :city, :state, :zip, :email)
  end

  def update_params
    updated_params = user_params
    if updated_params[:password] == ""
      updated_params.delete(:password)
    end
    if updated_params[:password_confirmation] == ""
      updated_params.delete(:password_confirmation)
    end
    updated_params
  end

  def check_user_status
    render file: "/public/404", status: 404 unless registered_user?
  end
end
