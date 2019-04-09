class Dashboard::ItemsController < ApplicationController

  before_action :check_merchant_status

  def index
    @items = Item.where(user_id: current_user.id)
  end

  def show
  end

  def new
  end

  def update
    item = Item.find(params[:id])
    if item.enabled?
      item.update(enabled: false)
      flash[:notice] = "#{item.name} no longer available for sale"
    else
      item.update(enabled: true)
      flash[:notice] = "#{item.name} now available for sale!"
    end
    redirect_to dashboard_items_path
  end

  private

  def check_merchant_status
    render file: "/public/404", status: 404 unless current_merchant?
  end
end
