class MerchantItemsController < ApplicationController
  before_action :set_merchant
  def index
    @merchant_items = @merchant.items.all
  end

  def show
    @merchant_item = @merchant.items.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def update
    @merchant_item = @merchant.items.find(params[:id])
    if @merchant_item.status == 0
      @merchant_item.status == 1
    elsif@merchant_item.status == 1
      @merchant_item.status == 0
    end
  end

  def enable_item
    @merchant_item = @merchant.items.find(params[:id])
    if @merchant_item.status == 0
      @merchant_item.update(status: params[:status])
      redirect_to merchant_items_path(@merchant), notice: "GREAT SUCCESS! The merch has been #{@merchant_item.status}."
    elsif @merchant_item.update(item_params)
      flash[:success] = "Item Info Successfully Updated"
      redirect_to merchant_item_path(@merchant, @merchant_item)
    else
      render :edit
    end
  end

  def disable_item
    @merchant_item = @merchant.items.find(params[:id])
    if @merchant_item.status == 1
      @merchant_item.update(status: params[:status])
      redirect_to merchant_items_path(@merchant), notice: "GREAT SUCCESS! The merch has been #{@merchant_item.status}."
    elsif @merchant_item.update(item_params)
      flash[:success] = "Item Info Successfully Updated"
      redirect_to merchant_item_path(@merchant, @merchant_item)
    else
      render :edit
    end
  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :status)
  end
end