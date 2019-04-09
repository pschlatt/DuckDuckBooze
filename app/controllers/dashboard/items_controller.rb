class Dashboard::ItemsController < ApplicationController

  before_action :check_merchant_status

  def index
    @items = Item.where(user_id: current_user.id)
  end

  def show
  end

  def new
  end

  private

  def check_merchant_status
    render file: "/public/404", status: 404 unless current_merchant?
  end

end
