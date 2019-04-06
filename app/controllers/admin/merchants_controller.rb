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

  def update
    user = User.find(params[:id])
    user.role = 'registered_user'
    binding.pry
    # user.save
    # user.items.update(enabled: false)
    flash[:notice] = "Merchant has been downgraded"
    redirect_to admin_user_path(user)
  end
end
