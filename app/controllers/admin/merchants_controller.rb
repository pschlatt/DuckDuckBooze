class Admin::MerchantsController < ApplicationController

  def show
    user = User.find(params[:id])
    if user.merchant? && user.enabled == true
      @merchant = user
    else
      current_merchant? == false
      redirect_to admin_user_path(current_user)
    end
  end
end
