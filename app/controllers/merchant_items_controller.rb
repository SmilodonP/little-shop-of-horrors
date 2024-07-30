class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:success] = "Item Info Successfully Updated"
      redirect_to merchant_item_path(@merchant, @item)
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end
end

