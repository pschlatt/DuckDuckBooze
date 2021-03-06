class Admin::UsersController < ApplicationController
  before_action :check_admin_status

  def index
    @users = User.where(role: 1)
  end

  def show
    @user = User.find(params[:id])
    if @user.role == 'merchant'
      redirect_to admin_merchant_path(@user)
    end
  end 

  def update
    user = User.find(params[:id])
    user.update!(role: 2)
    new_merch = user
    flash[:notice] = "User has been upgraded to a merchant"
    redirect_to admin_merchant_path(new_merch)
  end

  private

  def check_admin_status
    render file: "/public/404", status: 404 unless current_admin?
  end
end
