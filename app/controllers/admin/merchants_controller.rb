class Admin::MerchantsController < ApplicationController
  before_action :check_user_status
  def index
    @merchants = User.where(role: 2)
  end

  def show
    @merchant = User.find(params[:id])
    if @merchant.role == 'registered_user' 
      redirect_to admin_user_path(@merchant)
    end
  end

  def update
    user = User.find(params[:id])
    if params[:enabled]
      if params[:enabled] && params[:enabled] == "true"
        user.update!(enabled: true)
        flash[:notice] = "Merchant is now enabled"
        redirect_to admin_merchants_path
      else
        user.update!(enabled: false)
        flash[:notice] = "Merchant is now disabled"
        redirect_to admin_merchants_path
      end
    else
      user.update!(role: 1)
      user.disable_items(user.id)
      reg_user = user
      flash[:notice] = "Merchant has been downgraded"
      redirect_to admin_user_path(reg_user)
    end
  end

  private

  def check_user_status
    render file: "/public/404", status: 404 unless current_admin?
  end
end
