class Dashboard::MerchantsController < ApplicationController

  def show
    @merchant = current_user
  end
end
