class MerchantItemsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_item = @merchant.items.find(params[:id])
  end

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
    if @item.update(item_params)
      flash[:success] = "Item Info Successfully Updated"
      redirect_to merchant_items_path(@merchant)
    elsif params[:status]
      @item.update(status: params[:id])
      redirect_to merchant_items_path(@merchant), noticel: "GREAT SUCCESS! The merch has been #{@item.status}."
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end
end