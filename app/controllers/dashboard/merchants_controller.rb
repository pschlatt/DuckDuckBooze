class Dashboard::MerchantsController < ApplicationController
  before_action :check_merchant_status

  def show
    @merchant = current_user
  end

  private

  def check_merchant_status
    render file: "/public/404", status: 404 unless current_merchant?
  end

  private

  def check_merchant_status
    render file: "/public/404", status: 404 unless current_merchant?
  end
  
end
