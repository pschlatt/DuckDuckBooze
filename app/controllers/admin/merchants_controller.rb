class Admin::MerchantsController < ApplicationController
  before_action :check_user_status
  def index
  end 

  def show
    @merchant = User.find(params[:id])
    if @merchant.role == 'merchant' && @merchant.enabled == false 
      redirect_to admin_user_path(@merchant)
    end
  end

  def update
    user = User.find(params[:id])
    if params[:enabled] && params[:enabled] == "true"
      user.update!(enabled: true)
      flash[:notice] = "Merchant is now enabled"
      redirect_to admin_merchants_path
    else 
      user.update!(enabled: false)

     flash[:notice] = "Merchant is now disabled"
     redirect_to admin_merchants_path
   end 
  end

  private
  
  def check_user_status
    render file: "/public/404", status: 404 unless current_admin?
  end

end
