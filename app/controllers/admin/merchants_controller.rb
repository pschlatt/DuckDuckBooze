class Admin::MerchantsController < ApplicationController

  def show
    if current_merchant? == false
      redirect_to admin_user_path(current_user)
    end
  end

  def update

  end

end
