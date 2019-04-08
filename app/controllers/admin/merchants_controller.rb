class Admin::MerchantsController < ApplicationController
  before_action :check_user_status

  def show
    @merchant = User.find(params[:id])
    if @merchant.role == 'merchant' && @merchant.enabled == false 
      redirect_to admin_user_path(@merchant)
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
