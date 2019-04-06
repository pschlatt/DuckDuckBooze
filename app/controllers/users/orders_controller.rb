class Users::OrdersController < ApplicationController
  before_action :check_user_status

  def show
  end

  private

  def check_user_status
    render file: "/public/404", status: 404 unless registered_user?
  end
end
