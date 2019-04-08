class Admin::MerchantsController < ApplicationController
  before_action :check_user_status

  def show
    if current_admin?
      @user = User.find(params[:id])
    elsif current_merchant? == false
      redirect_to admin_user_path(current_user)
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
