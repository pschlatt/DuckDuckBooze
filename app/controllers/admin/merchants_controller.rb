class Admin::MerchantsController < ApplicationController
  before_action :check_user_status

  def show
    if current_merchant? == false
      redirect_to admin_user_path(current_user)
    end
  end

  private
  
  def check_user_status
    render file: "/public/404", status: 404 unless current_admin?
  end
end
