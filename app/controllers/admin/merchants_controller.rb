class Admin::MerchantsController < ApplicationController

  def show
    # binding.pry
    if current_merchant? == false
      redirect_to admin_user_path(current_user)
    end
  end

end
