class Admin::MerchantsController < ApplicationController
  before_action :check_user_status

  def show
    @user = User.find(params[:id])
    if @user.role == 'merchant' && @user.enabled == true 
      redirect_to admin_merchant_path(@user)
    elsif  
      redirect_to admin_user_path(@user)
    end
  end

  def update
    user = User.find(params[:id])
    user.update(role: 'registered_user')
    user.items.update(enabled: false)
    flash[:notice] = "Merchant has been downgraded"
    redirect_to admin_user_path(user)
  end

  private
  
  def check_user_status
    render file: "/public/404", status: 404 unless current_admin?
  end

end
