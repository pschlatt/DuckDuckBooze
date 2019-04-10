class Dashboard::ItemsController < ApplicationController

  before_action :check_merchant_status

  def index
    @items = Item.where(user_id: current_user.id)
  end

  def show
  end

  def new
    @item = Item.new
  end

  def create
    merchant = current_user
    @item = merchant.items.new(item_params)
    if @item.save
      flash[:notice] = "#{@item.name} has been added!"
      redirect_to dashboard_items_path
    else
      flash[:notice] = @item.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    if params[:item].present?
      item.update(item_params)
      flash[:notice] = "#{item.name} has been updated!"
    elsif item.enabled?
      item.update(enabled: false)
      flash[:notice] = "#{item.name} no longer available for sale"
    elsif
      item.update(enabled: true)
      flash[:notice] = "#{item.name} now available for sale!"
    end
    redirect_to dashboard_items_path
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    flash[:notice] = "#{item.name} has been deleted"
    redirect_to dashboard_items_path
  end

  private

  def check_merchant_status
    render file: "/public/404", status: 404 unless current_merchant?
  end

  def item_params
    params.require(:item).permit(:name, :description, :image, :item_price, :stock)
  end
end
