class Admin::DashboardController < ApplicationController
  before_action :check_admin_status

  def show
  end 

  private

  def check_admin_status
    render file: "/public/404", status: 404 unless current_admin?
  end
end 