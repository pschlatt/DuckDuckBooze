class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_action :check_user_status, only: [:show]

  def show
    @cartstuff = session[:cart]
  
  end

  def create
    item = Item.find(params[:item_id])
    @cart.add_item(item.id)
    session[:cart] = @cart.contents
    flash[:notice] = "You have added #{item.name} to your cart"
    redirect_to items_path
  end

  private

  def check_user_status
    render file: "/public/404", status: 404 unless registered_user? || current_user.nil?
  end
end
