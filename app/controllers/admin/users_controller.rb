class Admin::UsersController < ApplicationController
  before_action :check_admin_status

  def index
    @users = User.where(role: 1)
  end

  def show
  end

  private

  def check_admin_status
    render file: "/public/404", status: 404 unless current_admin?

  end

end
