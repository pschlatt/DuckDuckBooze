class Admin::MerchantsController < ApplicationController
  before_action :check_user_status

  def show
    user = User.find(params[:id])
    if user.merchant? && user.enabled == false 
      redirect_to admin_user_path(user)
    end
  end

  private
  
  def check_user_status
    render file: "/public/404", status: 404 unless current_admin?
  end
end
